class Tweet
  include Mongoid::Document
  include Mongoid::Timestamps

  field :content, type: String
  field :loc, type: Array
  field :tags, type: Array
  field :image_url, type: String
  field :username, type: String

  index({ loc: '2d', tags: 1 }, { background: true })

  validates_presence_of :image_url, :content, :loc, :username, :tags
end
