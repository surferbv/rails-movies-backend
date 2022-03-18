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
      
      # check number of records 
      expect(Movie.all.count).to eq(1)
    end
    
    it "POST /create" do
      headers = { "CONTENT_TYPE" => "application/json" }
      post "/movies", params: @movie_json
      expect(response).to have_http_status(:created)

      # check number of records 
      expect(Movie.all.count).to eq(2)

      # test bad formed json
    end

    it "GET /show" do
      get "/movies/#{@movie.id}"
      expect(response).to have_http_status(:success)

      # check number of records 
      expect(Movie.all.count).to eq(1)

      # test what if id does not exists
    end
    
    it "PUT /update" do
      put "/movies/#{@movie.id}", params: {
        movie:{
          name: @movie.name,
          rating: 6
        }
      }
      expect(response).to have_http_status(:ok)

      # check that response body has reflected changes
      sym_json = response_body.deep_symbolize_keys
      print_it(sym_json)
      expect(sym_json[:name]).to eq(@movie.name)
      expect(sym_json[:rating]).to eq(6)

      # check number of records 
      expect(Movie.all.count).to eq(1)
    end
    
    it "DELETE /destroy" do
      delete "/movies/#{@movie.id}"
      expect(response).to have_http_status(:success)

      # check number of records 
      expect(Movie.all.count).to eq(0)
    end


  end

  def response_body()
    JSON.parse(response.body)
  end

  def print_it(response)
    puts response
  end

end
