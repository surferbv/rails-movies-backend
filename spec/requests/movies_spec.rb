require 'rails_helper'

RSpec.describe MoviesController, type: :request do

  context "request test" do

    subject{ response_body }

    before{
      @movie1 = create(:movie1)
    }

    it "GET /index expect 200" do
      get "/movies"
      expect(response).to have_http_status(:success)
    end
    
    it "POST /create"

    it "GET /show" do
      get "/movies/1"
      expect(response).to have_http_status(:success)
    end

    it "PUT /update"

    it "DELETE /destroy"


  end

  def response_body()
    JSON.parse(response.body)
  end

end
