FactoryGirl.define do
  factory :upvote do
    upvotable_id 1
    upvotable_type "Product"
    user_id 1
  end

end
