namespace :products do
  desc "Scraping a-land products"
    task :scrape_aland => :environment do
      require "json"
      require "rest-client"

      api_key = Rails.application.secrets.kimono_api_key
      response = RestClient.get("https://www.kimonolabs.com/api/e205sfvu?apikey=#{api_key}", {:accept => :json})

      # Now we can print out the data we got
      puts "All data received:"
      data = JSON.parse(response)
      products = data["results"]["collection1"]

      puts JSON.pretty_generate(products)

      products.each do |item|
        Product.create!(:title => item["title"]["text"], :link =>  item["title"]["href"], :image => item["image"]["src"], :unit_price => item["unit_price"])
      end
  end
end
