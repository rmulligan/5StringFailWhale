require 'eventmachine'
require 'fiber'

class TweetPersistMachine
  def self.runner
    Mongoid.logger = nil # Speed up by killing logs for while streaming

  end
end
