module Recommendations
  module Helpers
    module Calculations
      class << self
        def similarity_between(user, other_user)
          user_id = user.id.to_s
          other_user_id = other_user.id.to_s

          similarity = liked_count = 0

        end
      end
    end
  end
end
