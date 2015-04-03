# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


categories = [{title: "tops", description: ""}, {title: "t-shirt", description: ""}, {title: "shirt", description: ""}, {title: "knit/cardigan"}, {title: "sweatshirt", description: ""}, {title: "hoodie", description: ""}, {title: "sleeveless", description: ""}, {title: "bottoms", description: ""}, {title: "pants", description: ""}, {title: "jeans", description: ""}, {title: "shorts", description: ""}]

Category.create!(categories)
shops = [{name: "Aland", description: "Aland Co. has been presenting a variety of fashion cultures to many people as a multi-brand store with new fashion designers. Now we are selling everything—clothes, shoes, bags and stationary items—can be touched by designer's sense.", website: "http://www.a-land.co.kr/shop/main/index.php/", facebook_url: "https://www.facebook.com/pages/%EB%AA%85%EB%8F%99A-Land/347084205351376?fref=ts&rf=551345544892298"}]
Shop.create!(shops)
