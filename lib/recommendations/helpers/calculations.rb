module Recommendations
  module Helpers
    module Calculations
      class << self
        # Calculate a numeric similarity value that can fall between -1.0 and 1.0.
        # A value of 1.0 indicates that both users have rated the same items in
        # the same ways. A value of -1.0 indicates that both users have rated the
        # same items in opposite ways.
        def similarity_between(user_id, other_user_id)
          user_id = user_id.to_s
          other_user_id = other_user_id.to_s

          similarity = liked_count = 0
          in_common = Recommendations.config.ratable_classes.each do |klass|
            liked_set = Recommendations::Helpers::RedisKeyMapper.liked_set_for(klass, user_id)
            other_liked_set = Recommendations::Helpers::RedisKeyMapper.liked_set_for(klass, other_user_id)

            results = Recommendations.redis.pipelined do
              # Return the members of the set resulting from the intersection of all the given sets
              Recommendations.redis.sinter(liked_set, other_liked_set)
              # Return the set cardinality (number of elements) of the set stored in set
              Recommendations.redis.scard(liked_set)
            end

            similarity = results[0].size
            liked_count = results[1]
          end

          similarity / (liked_count).to_f
        end

        # Predict how likely it is that a user will like an item. This probability
        # is not based on percentage. 0.0 indicates that the user will neither like
        # nor dislike the item. Values that approach Infinity indicate a rising
        # likelihood of liking the item.
        def predict_for(user_id, klass, item_id)
          user_id = user_id.to_s
          item_id = item_id.to_s

          liked_by_set = Recommendations::Helpers::RedisKeyMapper.liked_by_set_for(klass, item_id)
          similarity_sum = 0.0

          # Get sum of similarities of each item in set
          similarity_sum = similarity_total_for(user_id, liked_by_set)

          liked_by_count = Recommendations.redis.pipelined do
            Recommendations.redis.scard(liked_by_set)
          end
          prediction = similarity_sum / (liked_count).to_f
          prediction.finite ? prediction : 0.0
        end

        def update_similarities_for(user_id)
          user_id = user_id.to_s
          similarity_set = Recommendations::Helpers::RedisKeyMapper.similarity_set_for(user_id)

          # Only calculate similarities for users who have rated the items that
          # this user has rated
          relevant_user_ids = Recommendations.config.ratable_classes.inject([]) do |memo, klass|
            liked_set = Recommendations::Helpers::RedisKeyMapper.liked_set_for(klass, user_id)

            item_ids = Recommendations.redis.sunion(liked_set)

            unless item_ids.empty?
              sets = item_ids.map do |id|
                liked_by_set = Recommendations::Helpers::RedisKeyMapper.liked_by_set_for(klass, id)

                [liked_by_set]
              end

              memo | Recommendations.redis.sunion(*sets.flatten)
            else
              memo
            end
          end

          similarity_values = relevant_user_ids.map { |id| similarity_between(user_id, id) }
          Recommendations.redis.pipelined do
            relevant_user_ids.zip(similarity_values).each do |id, similarity_value|
              next if id == user_id # Skip comparing with self.
              Recommendations.redis.zadd(similarity_set, similarity_value, id)
            end
          end

          if knn = Recommendations.config.nearest_neighbors
            length = Recommendations.redis.zcard(similarity_set)
            kfn = Recommendations.config.furthest_neighbors || 0

            Recommendations.redis.zremrangebyrank(similarity_set, kfn, length - knn - 1)
          end

          true
        end

        # Used internally to update this user's prediction values across all
        # Recommendations types. This is called by the background worker.

        def similarity_total_for(user_id, set)
          similarity_set = Recommendations::Helpers::RedisKeyMapper.similarity_set_for(user_id)
          ids = Recommendations.redis.smembers(set)
          similarity_values = Recommendations.redis.pipelined do
            ids.each do |id|
              Recommendations.redis.zscore(similarity_set, id)
            end
          end
          similarity_values.map(&:to_f).reduce(&:+).to_f
        end

        def update_score_for(klass, id)
          score_set = Recommendations::Helpers::RedisKeyMapper.score_set_for(klass)
          liked_by_set = Recommendations::Helpers::RedisKeyMapper.liked_by_set_for(klass, id)
          liked_by_count = Recommendations.redis.pipelined do
            Recommendation.redis.scard(liked_by_set)
          end

          return 0.0 unless liked_by_count > 0
          z = 1.96
          n = liked_by_count
          phat = liked_by_count / n.to_f

          begin
            score = (phat + z*z/(2*n) - z * Math.sqrt((phat*(1-phat)+z*z/(4*n))/n))/(1+z*z/n)
          rescue Math::DomainError
            score = 0
          end

          Recommendations.redis.zadd(score_set, score, id)
          true
        end


      end
    end
  end
end
