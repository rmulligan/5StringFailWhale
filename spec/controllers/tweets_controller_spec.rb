require 'spec_helper'

describe TweetsController do
  describe "GET#index" do
    it "renders the :index view" do
      get :index
      response.should render_template :index
    end
  end

  it "renders the #search view" do
    request.env["HTTP_ACCEPT"] = 'application/javascript'
    t = Fabricate(:tweet)
    get :search, tags: "tag1", latitude: t.loc[0], longitude: t.loc[1]
    response.should render_template :search
  end
end
