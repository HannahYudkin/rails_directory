require 'rails_helper'

RSpec.describe UsersController do
  describe "GET #index" do
    before do
      get :index
    end
    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    # it "JSON body response contains user attributes" do
    #   json_response = JSON.parse(response.body)
    #   expect(response).to match_response_schema("user")
    # end
  end
end