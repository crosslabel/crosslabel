require 'recommendations/rater/viewer'
require 'recommendations/rater/upvoter'
require 'recommendations/rater/recommender'

module Recommendations
  module Rater
    extend ActiveSupport::Concern

    module ClassMethods
      def recommends(*things)
        Recommendations.configure do |config|
          config.ratable_classes = []
          config.user_class = self
        end

        things.each { |thing| thing.to_s.classify.constantize.make_recommendable! }

        
      end
    end
  end
end
