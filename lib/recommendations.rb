require 'active_support'

require 'recommendations/configuration'
require 'recommendations/helpers'
require 'recommendations/rater'
require 'recommendations/ratable'


require 'recommendations/workers/resque'

module Recommendations
  class << self
    def redis
      config.redis
    end
  end
end
