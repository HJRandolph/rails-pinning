require 'spec_helper'

RSpec.describe "Followers", type: :request do
  describe "GET /followers" do
    it "works! (now write some real specs)" do
      get followers_path #Without a user logged in, this should redirect to login
      expect(response).to have_http_status(302)
    end
    
    it "works! (now write some real specs)" do
      get followers_path #Without a user logged in, this should redirect to login
      expect(response).to redirect_to(:login)
    end
    
  end
end
