require 'eventmachine'
require 'em-http'
require 'fiber'

class TweetPersistMachine
  def self.runner
    Mongoid.logger = nil # Skip logging while streaming to boost performance
    count = 0
    @client = TweetStream::Client.new

    EM.run do
      puts "Inserting Tweets with coordinates and hashtags"

      EM.add_periodic_timer(10) do
        puts "Inserted #{count} tweets"
      end

      @client.locations(-180,-90,180,90) do |tweet|
        # New fiber for db insertion
        fiber = Fiber.new do
          tags = Array.new
          if tweet.hashtags
            tweet.hashtags.map{|tag| tags << tag.text}
          end

          latitude = tweet.geo.latitude
          if latitude.is_a?(Float) && tweet.hashtags?
            Tweet.create!({
                            :loc => [latitude, tweet.geo.longitude],
                            :tags => tags,
                            :content => tweet.text
                      })
          end
        end

        EM.next_tick do
          fiber.resume
          count = Tweet.all.count
        end
      end
    end
  end
end
