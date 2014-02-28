class TweetsController < ApplicationController
  def index;end;

  def search
    latitude  = params[:latitude].to_f
    longitude = params[:longitude].to_f
    radius    = params[:radius].to_f * (Math::PI / 180) # Convert to radians
    tags      = params[:tags].split(",").map{|s|s.strip.reverse.chomp("#").reverse.downcase}
    tags << tags.map(&:titlecase)
    @relevent_tweets = Tweet.in(:tags=> tags.flatten).geo_near([ latitude, longitude ]).max_distance(radius).sort { |x,y| x.created_at <=> y.created_at }
  end
end
