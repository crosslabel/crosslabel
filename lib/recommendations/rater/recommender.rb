module Recommendations
  module Rater
    module Recommender
      # Get a list of raters that have been found to be the most similar to
      # self. They are sorted by the calculated similarity value.
      #
      # @param [Fixnum] limit the number of users to return (defaults to 10)
      # @return [Array] An array of instances of your user class
      def similar_raters(limit = 10, offset = 0)
        ids = Recommendations.redis.zrevrange(Recommendations::Helpers::RedisKeyMapper.similarity_set_for(id), 0, -1)

        order = ids.map { |id| "`#{Recommendations.config.user_class.table_name}`.`id` = %d DESC" }.join(', ')
        order = self.class.send(:sanitize_sql_for_assignment, [order, *ids])

        Recommendations.query(self.class, ids).order(order).limit(limit).offset(offset)
      end

      private

      # Fetch a list of recommendations for a passed class.
      #
      # @param [String, Symbol, Class] klass the class from which to get recommendations
      # @param [Fixnum] limit the number of recommendations to fetch (defaults to 10)
      # @return [Array] a list of things this person's gonna love
      def recommended_for(klass, limit = 10, offset = 0)
        recommended_set = Recommendations::Helpers::RedisKeyMapper.recommended_set_for(klass, self.id)
        return Recommendations.query(klass, []) unless rated_anything? && Recommendations.redis.zcard(recommended_set) > 0

        ids = Recommendations.redis.zrevrange(recommended_set, 0, -1, :with_scores => true)
        ids = ids.select { |id, score| score > 0 }.map { |pair| pair.first }

        order = ids.map { |id| "`#{klass.table_name}`.`id` = %d DESC" }.join(', ')
        order = klass.send(:sanitize_sql_for_assignment, [order, *ids])
        Recommendations.query(klass, ids).order(order).limit(limit).offset(offset)
      end

      # Removes an item from a user's set of recommendations
      # @private
      def unrecommend(obj)
        Recommendations.redis.zrem(Recommendations::Helpers::RedisKeyMapper.recommended_set_for(obj.class, id), obj.id)
        true
      end

      # Removes a user from Recommendations. Called internally on a before_destroy hook.
      # @private
      def remove_from_recommendations!
        sets  = [] # SREM needed
        zsets = [] # ZREM needed
        keys  = [] # DEL  needed

        # Remove from other users' similarity ZSETs
        zsets += Recommendations.redis.keys(Recommendations::Helpers::RedisKeyMapper.similarity_set_for('*'))

        # Remove this user's similarity ZSET
        keys << Recommendations::Helpers::RedisKeyMapper.similarity_set_for(id)

        # For each ratable class...
        Recommendations.config.ratable_classes.each do |klass|
          # Remove this user from any class member's liked_by
          sets += Recommendations.redis.keys(Recommendations::Helpers::RedisKeyMapper.liked_by_set_for(klass, '*'))

          # Remove this user's liked/recommended sets for the class
          keys << Recommendations::Helpers::RedisKeyMapper.liked_set_for(klass, id)
          keys << Recommendations::Helpers::RedisKeyMapper.recommended_set_for(klass, id)
        end

        Recommendations.redis.pipelined do |redis|
          sets.each { |set| redis.srem(set, id) }
          zsets.each { |zset| redis.zrem(zset, id) }
          redis.del(*keys)
        end
      end
    end
  end
end
