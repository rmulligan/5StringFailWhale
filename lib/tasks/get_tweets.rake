require 'tweet_persist_machine'

desc "get tweets"
task(:get_tweets => :environment) do
  TweetPersistMachine.runner
end
