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

          if tweet.geo.latitude.is_a?(Float)
            t = Tweet.new({
                            :loc => [tweet.geo.latitude, tweet.geo.longitude],
                            :tags => tags,
                            :content => tweet.text,
                            :username => tweet.user.username,
                            :image_url => tweet.user.profile_image_url
                          })
            count = count + 1 if t.save
          end
        end

        EM.next_tick do
          fiber.resume
        end
      end
    end
  end
end
