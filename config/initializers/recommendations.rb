require 'redis'
require 'active_record'

ActiveRecord::Base.send(:include, Recommendations::Rater)
ActiveRecord::Base.send(:include, Recommendations::Ratable)

Recommendations.configure do |config|
  # Recommendation's connection to Redis
  if ENV["REDISCLOUD_URL"]
    config.redis = Redis.new(:url => ENV["REDISCLOUD_URL"])
  else
    config.redis = Redis.new(:host => 'localhost', :port => 6379, :db => 0)
  end



  # A prefix for all keys Recommendable uses
  config.redis_namespace = :recommendations

  # Whether or not to automatically enqueue users to have their recommendations
  # refreshed after they like/dislike an item
  config.auto_enqueue = true

  # The number of nearest neighbors (k-NN) to check when updating
  # recommendations for a user. Set to `nil` if you want to check all
  # other users as opposed to a subset of the nearest ones.
  config.nearest_neighbours = nil
end
