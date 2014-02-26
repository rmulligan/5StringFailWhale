class Tweet
  include Mongoid::Document
  include Mongoid::Timestamps

  field :content, type: String
  field :loc, type: Array
  field :tags, type: Array

  index({ loc: '2d', tags: 1 }, { background: true })
end
