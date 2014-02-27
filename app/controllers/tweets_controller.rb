class TweetsController < ApplicationController
  def index;end;

  def search
    latitude  = params[:latitude].to_f
    longitude = params[:longitude].to_f
    radius    = params[:radius].to_i
    tag       = params[:tag]

    relevent_tweets = Tweet.in(:tags=> [tag]).geo_near([ latitude, longitude ]).max_distance(radius)

    render :json => relevent_tweets.to_json
  end
end
