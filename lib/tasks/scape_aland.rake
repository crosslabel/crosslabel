namespace :aland do
  desc "Scraping a-land tops"
    task :scrape_tops => :environment do
      require "json"
      require "rest-client"

      api_key = Rails.application.secrets.kimono_api_key
      response = RestClient.get("https://www.kimonolabs.com/api/e205sfvu?apikey=#{api_key}", {:accept => :json})

      # Now we can print out the data we got
      puts "All data received:"
      data = JSON.parse(response)
      products = data["results"]["collection1"]

      puts JSON.pretty_generate(products)

      shop = Retailer.find_by(name: "A-Land")
      category = Category.find_by(:title => :tops)

      if shop.present? && category.present?
        products.each do |item|
          product = Product.create!(:title => item["title"]["text"], :link =>  item["title"]["href"], :shop_id => shop.id, :image => item["image"]["src"], :unit_price => item["unit_price"])
          category.products << product
        end
      else
        puts "Retailer or category was not found"
        break
      end
  end
end
