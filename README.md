Location Based Twitter Public Stream Viewer
=========
[View on Heroku](http://secret-refuge-1214.herokuapp.com/)

By utilizing the Twitter Streaming API,
create a Rails 3 App that show tweets from a location specified by the user.

1. Create a rake task that:
  - Consumes the Twitter Public Stream API
  - Inserts Tweets into a MongoDB “tweets” collection that has a geo-spatial index to ensure fast query
  - Store hashtags along the tweet document as an indexed array field, indexed along with the above geo field as a “compound index"
  - Use Ruby fiber along EventMachine to speed up tweet insertion

2.  On a simple Rails page, the user should be able to:
  - Enter the lat/long coordinates with an radius in a form
  - See all the tweets within that area, paginated descendingly by time
  - Search for tweets within the above area with a specific hangtag (i.e.: #amazing, #super, #obama, etc)

Requirements:
=========

>Ruby 2, Rails 3, Mongoid 3
>TDD with RSpec
>Git/Github, commit often with comments

Resources: 
=========
https://dev.twitter.com/docs/streaming-apis/streams/public
https://github.com/tweetstream/tweetstream
http://docs.mongodb.org/manual/applications/geospatial-indexes
http://www.igvita.com/2009/05/13/fibers-cooperative-scheduling-in-ruby/

Bonus:
=====
- Use Google Maps to visualize location of Tweets
- Deploy to Heroku


License
----

MIT
