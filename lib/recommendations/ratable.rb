require 'recommendations/ratable/upvotable'
module Recommendable
  module Ratable
    extend ActiveSupport::Concern

    def recommendable?() self.class.recommendable? end

    module class_methods
      # Adds class to
      def make_recommendable!
        Recommendations.configure { |config| config.ratable_classes << self }

        class_eval do
          # Whether or not items belonging to this class can be recommended.

          def self.recommendable?() true end
            # Returns the class that has been explicitly been made ratable, whether it is this
              # class or a superclass. This allows a ratable class and all of its subclasses to be
              # considered the same type of ratable and give recommendations from the base class
              # or any of the subclasses.
          def self.ratable_class
            ancestors.find { |klass| Recommendable.config.ratable_classes.include?(klass) }
          end

        end
      end
    end
  end
end
