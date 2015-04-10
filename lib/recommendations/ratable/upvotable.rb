module Recommendations
  module Ratable
    module Upvotable
      def liked_by
        Recommendations.config.user_class.where(:id =>  liked_by_ids)
      end

      # Get the number of users that have liked this item
      def liked_by_count
        Recommendations.redis.scard(Recommendations::Helpers::RedisKeyMapper.liked_by_set_for(self.class, id))
      end
      # Get IDs of users that have liked this item
      def liked_by_ids
        Recommendations.redis.smembers(Recommendations::Helpers::RedisKeyMapper.liked_by_set_for(self.class, id))
      end
    end
  end
end
