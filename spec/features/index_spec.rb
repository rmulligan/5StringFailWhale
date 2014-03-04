require 'spec_helper'
require 'uri'

describe "index", :type => :feature do
  before(:each) do
    visit root_path
  end

  it "loads index" do
    page.should have_content("Search twitter")
  end

  it "does not display results", :js => true do
    page.should_not have_css("#results")
  end

  it "does display results", :js => true do
    click_button "Search!"
    page.should have_css("#results")
  end

  it "should return callback function" do
    VCR.use_cassette "tags/banjo" do
      uri = URI.parse('http://localhost:3000/tweet-search')
      params = { :tags => "smile", :latitude => 43.01618428, :longitude => -78.8179085, :radius => 20 }
      uri.query = URI.encode_www_form(params)
      response = Net::HTTP.get_response(uri)
      response.body.should include("addResults(")
    end
  end

  it "should return results" do
    VCR.use_cassette "tags/banjo" do
      uri = URI.parse("http://localhost:3000/tweet-search")
      params = { :tags => "smile", :latitude => 43.01618428, :longitude => -78.8179085, :radius => 20 }
      uri.query = URI.encode_www_form(params)
      response = Net::HTTP.get_response(uri)
      expect {JSON.parse(response.body.scan(/addResults\((.*)\);/)[0][0])}.to_not raise_error
    end
  end
end
