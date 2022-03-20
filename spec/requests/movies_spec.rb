require 'rails_helper'

RSpec.describe MoviesController, type: :request do

  context "REST request test" do

    subject{ response_body }

    before{
      @movie = create(:movie)
      @movie_json = { movie: {name: "Terminaor 2", rating: 5} }
      @request_param_incorrect ={ movie:{ na: "Tom", rating: 5 } }
    }

    it "GOOD: GET /index expect 200" do
      get "/movies"
      expect(response).to have_http_status(:success)
      expect(Movie.all.count).to eq(1)
    end
    
    it "GOOD: POST /create expect 200" do
      headers = { "CONTENT_TYPE" => "application/json" }
      post "/movies", params: @movie_json
      expect(response).to have_http_status(:created)
      json = response_body.deep_symbolize_keys
      expect(json[:name]).to eq(@movie_json[:movie][:name])
      expect(json[:rating]).to eq(@movie_json[:movie][:rating])
      expect(Movie.all.count).to eq(2)
    end

    it "GOOD: GET /show expect 200" do
      get "/movies/#{@movie.id}"
      expect(response).to have_http_status(:success)
      expect(Movie.all.count).to eq(1)
    end
    
    it "GOOD: PUT /update expect 200" do
      put "/movies/#{@movie.id}", params: {
        movie:{
          name: @movie.name,
          rating: 6
        }
      }
      expect(response).to have_http_status(:ok)

      # check that response body has reflected changes
      json = response_body.deep_symbolize_keys
      expect(json[:name]).to eq(@movie.name)
      expect(json[:rating]).to eq(6)

      # check number of records 
      expect(Movie.all.count).to eq(1)
    end
    
    it "GOOD: DELETE /destroy expect 200" do
      delete "/movies/#{@movie.id}"
      expect(response).to have_http_status(:success)
      expect(Movie.all.count).to eq(0)
    end

    it "BAD: Get /show wrong id expect 404" do
      get '/movies/500'
      json = response_body.deep_symbolize_keys
      expect(response).to have_http_status(:not_found)
      expect(json[:error]).to eq('Movie not found.')
    end

    it "BAD: POST /create request param incorrect expect 422" do
      headers = { "CONTENT_TYPE" => "application/json" }
      post "/movies", params: @request_param_incorrect
      json = response_body.deep_symbolize_keys
      expect(response).to have_http_status(:unprocessable_entity)
      expect(json[:error]).to eq( "Movie failed to be created." )
    end

    it "BAD: PUT /update/:id wrong id expect 404" do
      put "/movies/500", params: {
        movie:{
          name: @movie.name,
          rating: 6
        }
      }
      json = response_body.deep_symbolize_keys
      expect(response).to have_http_status(:not_found)
      expect(json[:error]).to eq("Movie was not updated record not found.")
    end


    it "BAD: DELETE /movie/:id wrong id expect 404" do
      delete "/movies/500"
      expect(response).to have_http_status(:not_found)
      expect(Movie.all.count).to eq(1)
    end


  end

  def response_body()
    @response_body ||= JSON.parse(response.body)
  end

  def print_it()
    puts response_body
  end

end
