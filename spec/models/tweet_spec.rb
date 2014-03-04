require 'spec_helper'

describe Tweet do
  it { should have_fields(:loc, :tags).of_type(Array) }
  it { should have_fields(:content, :image_url, :username).of_type(String) }
  it { should be_timestamped_document }
  it { should have_index_for({ loc: '2d', tags: 1}).with_options(background: true) }


  it "should have loaded the factory" do
    tweet = Fabricate(:tweet)
    tweet.tags.should include("tag1")
  end

  it "should create new tweet record" do
    tweet = Fabricate(:tweet) #Tweet.new({:loc => [38.6875328, -121.2911305],  :tags => ["tag1","tag2"], :content => "My Tweet"})
    tweet.should be_valid
    tweet.save.should be_true
  end

  it "should not create a tweet with missing attributes" do
    tweet = Fabricate.build(:tweet, username: nil)
    tweet.should_not be_valid
  end

end
