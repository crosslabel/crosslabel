# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


categories = [{title: "Tops", description: ""}, {title: "t-shirt", description: ""}, {title: "shirt", description: ""}, {title: "knit/cardigan"}, {title: "sweatshirt", description: ""}, {title: "hoodie", description: ""}, {title: "sleeveless", description: ""}, {title: "bottoms", description: ""}, {title: "pants", description: ""}, {title: "jeans", description: ""}, {title: "shorts", description: ""}]

Category.create(categories)
