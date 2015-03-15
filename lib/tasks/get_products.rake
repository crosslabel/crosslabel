namespace :products do
  desc "Scraping a-land products"
    task :scrape_aland => :environment do
      require "importio.rb"
      require "json"

      # To use an API key for authentication, use the following code:
      client = Importio::new(Rails.application.secrets.importio_guid_key, Rails.application.secrets.importio_api_key, "https://query.import.io")

      # Once we have started the client and authenticated, we need to connect it to the server:
      client.connect

      # Define here a global variable that we can put all our results in to when they come back from
      # the server, so we can use the data later on in the script
      data_rows = []

      # In order to receive the data from the queries we issue, we need to define a callback method
      # This method will receive each message that comes back from the queries, and we can take that
      # data and store it for use in our app
      callback = lambda do |query, message|
        # Disconnect messages happen if we disconnect the client library while a query is in progress
        if message["type"] == "DISCONNECT"
          puts "The query was cancelled as the client was disconnected"
        end
        if message["type"] == "MESSAGE"
          if message["data"].key?("errorType")
            # In this case, we received a message, but it was an error from the external service
            puts "Got an error!"
            puts JSON.pretty_generate(message["data"])
        	else
            # We got a message and it was not an error, so we can process the data
            puts "Got data!"
            puts JSON.pretty_generate(message["data"])
            # Save the data we got in our dataRows variable for later
            data_rows << message["data"]["results"]
          end
        end
        if query.finished
          puts "Query finished"
        end
      end

      # Issue queries to your data sources with your specified inputs
      # You can modify the inputs and connectorGuids so as to query your own sources
      # Query for tile aland crawler men tops
      client.query({"input"=>{"webpage/url"=>"http://www.a-land.co.kr/shop/goods/goods_list.php?category=007"},"connectorGuids"=>["20d8db83-770b-4bcd-bbff-53a239ba4332"]}, callback )

      puts "Queries dispatched, now waiting for results"

      # Now we have issued all of the queries, we can wait for all of the threads to complete meaning the queries are done
      client.join

      puts "Join completed, all results returned"

      # It is best practice to disconnect when you are finished sending queries and getting data - it allows us to
      # clean up resources on the client and the server
      client.disconnect

      # Now we can print out the data we got
      puts "All data received:"
      puts JSON.pretty_generate(data_rows)

  end
end
