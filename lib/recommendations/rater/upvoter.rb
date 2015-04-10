module Recommendations
  module Rater
    module Upvoter
      # like an object
      def like(obj)
        raise(ArgumentError, 'Object is not ratable.') unless obj.respond_to?(:recommendable?) && obj.recommendable?
        return if liked?(obj)

        Recommendations.redis.sadd(Recommendations::Helpers::RedisKeyMapper.liked_set_for(obj.class, id), obj.id)
        Recommendations.redis.sadd(Recommendations::Helpers::RedisKeyMapper.liked_by_set_for(obj.class, obj.id), id)
      end

      # check whether user has liked object
      def liked?(obj)
        Recommendations.redis.sismember(Recommendations::Helpers::RedisKeyMapper.liked_set_for(obj.class, id), obj.id)
      end

      # Remove object from users set of likes
      def unlike(obj)
        return unless liked?(obj)
        Recommendations.redis.srem(Recommendations::Helpers::RedisKeyMapper.liked_set_for(obj.class, id), obj.id)
        Recommendations.redis.srem(Recommendations::Helpers::RedisKeyMapper.liked_by_set_for(obj.class, obj.id), id)
      end

      # Retrieve an array of objects the user has liked
      def likes
        Recommendations.config.ratable_classes.map { |klass| liked_for(klass)}.flatten
      end

      def likes_in_common_with(user)
        Recommendations.config.ratable_classes.map { |klass| liked_in_common_with(klass, user)}.flatten
      end

      def likes_count
        Recommendations.config.ratable_classes.inject(0) do |sum, klass|
          sum + liked_count_for(klass)
        end
      end

      private

      # Fetch ids for objects belonging to a passed class that the user has liked.
      def liked_ids_for(klass)
        ids = Recommendations.redis.smembers(Recommendations::Helpers::RedisKeyMapper.liked_set_for(klass, id))
        ids.map!(&:to_i)
        ids
      end

      # Fetch records belonging to a passed class that the user has liked.
      def liked_for(klass)
        klass.where(:id => liked_ids_for(klass))
      end

      # Get the number of items belonging to the passed class that the userh as liked
      def liked_count_for(klass)
        Recommendations.redis.scard(Recommendations::Helpers::RedisKeyMapper.liked_set_for(klass, id))
      end

      # Get records that both this user and a passed user have liked

      def liked_in_common_with(klass, user)
        klass.where(:ids => liked_ids_in_common_with(klass, user))
      end

      # Get a list of IDs for records that both this user and a passed user have in common
      def liked_ids_in_common_with(klass, user)
        user_id = user.id if user.is_a?(Recommendations.config.user_class)
        Recommendations.redis.sinter(Recommendations::Helpers::RedisKeyMapper.liked_set_for(klass, id), Recommendations::Helpers::RedisKeyMapper.liked_set_for(klass, user_id))
      end



    end
  end
end
