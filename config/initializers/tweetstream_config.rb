require 'tweetstream'

TCONFIG = YAML.load(ERB.new(File.read("#{Rails.root}/config/tweetstream.yml")).result)

TweetStream.configure do |config|
  config.consumer_key = TCONFIG["twitter"]["consumer_key"]
  config.consumer_secret = TCONFIG["twitter"]["consumer_secret"]
  config.oauth_token = TCONFIG["twitter"]["oauth_token"]
  config.oauth_token_secret = TCONFIG["twitter"]["oauth_token_secret"]
  config.auth_method = :oauth
end
