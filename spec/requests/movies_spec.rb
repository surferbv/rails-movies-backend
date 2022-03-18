require 'rails_helper'

RSpec.describe MoviesController, type: :request do

  context "request test" do

    subject{ response_body }

    before{
      @movie = create(:movie)
      @movie_json = { name: "Terminaor 2", rating: 5 }
    }

    it "GET /index expect 200" do
      get "/movies"
      expect(response).to have_http_status(:success)
    end
    
    it "POST /create" do
      headers = { "CONTENT_TYPE" => "application/json" }
      post "/movies", params: @movie_json
      expect(response).to have_http_status(:created)
    end

    it "GET /show" do
      get "/movies/#{@movie.id}"
      expect(response).to have_http_status(:success)
    end
    
    # TODO: Not working
    it "PUT /update" do
      put "/movies/#{@movie.id}", params: {
        movie:{
          name: @movie.name,
          rating: 6
        }
      }
      expect(response).to have_http_status(:ok)
    end
    
    it "DELETE /destroy" do
      delete "/movies/#{@movie.id}"
      expect(response).to have_http_status(:success)
    end


  end

  def response_body()
    JSON.parse(response.body)
  end

end
