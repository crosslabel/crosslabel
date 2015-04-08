require 'redis'

module Recommendations
  class Configuration
    # Connection to Redis
    # Default: localhost:6379/0
    attr_accessor :redis
    # A prefix for all redis keys
    attr_accessor :redis_namespace
    # Whether or not to automatically enqueue users to have their recommendations refreshed after they like or dislike an item.
    attr_accessor :auto_enqueue

    # The nearest number of (k-NN) to check when updating recommendations for a user. Set to 'nil' if you want to check all neighbours
    # as opposed to a subset of the nearest ones.
    attr_accessor :nearest_neighbours

    # Like kNN, but also uses some number of most dissimilar users when
    # updating recommendations for a user. Because, hey, disagreements are
    # just as important as agreements, right? If `nearest_neighbors` is set to
    # `nil`, this configuration is ignored. Set this to a lower number
    # to improve Redis memory usage.
    #
    # Default: nil
    attr_accessor :furthest_neighbors

    # The number of recommendations to store per user. Set this to a lower
    # number to improve Redis memory usage.
    #
    # Default: 100
    attr_accessor :recommendations_to_store

    attr_accessor :ratable_classes, :user_class

    def initialize
      @redis = Redis.new
      @redis_namespace = :recommendations
      @auto_enqueue = []
      @ratable_classes = []
      @nearest_neighbours = nil
      @furthest_neighbours = nil
      @recommendations_to_store = 100
    end

    class << self
      def configure
        @config ||= Configuration.new
        yield @config
      end
    end

  end
end
