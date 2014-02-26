require 'spec_helper'

describe Tweet do
  it { should have_fields(:loc, :tags).of_type(Array) }
  it { should be_timestamped_document }
  it { should have_index_for({ loc: '2d', tags: 1}).with_options(background: true) }

  it "should create new tweet record" do
    tweet = Tweet.new({:loc => [38.6875328, -121.2911305],  :tags => ["tag1","tag2"], :content => "My Tweet"})
    tweet.should be_valid
    tweet.save.should be_true
  end
end
