class TweetsController < ApplicationController
  def index;end;

  def search
    latitude  = params[:latitude].to_f
    longitude = params[:longitude].to_f
    radius    = params[:radius].to_f * (Math::PI / 180)
    tags      = params[:tags].split(",").map{|s|s.strip.reverse.chomp("#").reverse}

    @relevent_tweets = Tweet.in(:tags=> tags).geo_near([ latitude, longitude ]).max_distance(radius) #convert to radians
  end
end
