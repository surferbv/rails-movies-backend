class MoviesController < ApplicationController

  # rescue_from StandardError do |e|
  #   if e.instance_of? ActiveRecord::RecordInvalid
  #     message = e.record.errors.full_messages.to_sentence
  #     render json: {errors: message}, status: :unprocessable_entity
  #   else
  #     #  Don't understand this exception, can't provide a known error response.
  #     raise e
  #   end
  # end

  
  # get
  def index
    movies = Movie.all
    render json: movies
  end
  
  # post
  # format { "name": "acme", "raiting": "10" }
  def create
    # .create! is equivalent to .new followed by .save! (throws an error if saving fails). It's also just a wee bit shorter
    # Movie.create!(params[:movie])
    # render json: {message: "Movie was created successfully."}, status: :created

    movie = Movie.new( movie_params() )
    if movie.save
      render json: {name: movie.name, rating: movie.rating}, status: :created
    else
      render json: {error: "Movie failed to be created."}, status: :unprocessable_entity
    end

    # movie = Movie.create!( movie_params() )
    # render json: movie, status: :created
  end

  # get
  def show
    begin
      movie = Movie.find(params[:id])
      render json: movie, status: 200
    rescue ActiveRecord::RecordNotFound => e
      render json: {error: "Movie not found."}, status: :not_found
    rescue StandardError => e
      e
    end
  end

  # put
  # responsible for updating the existing record
  # format { "name": "acme", "raiting": "10" }
  def update
    begin
      movie = Movie.find(params[:id])
      movie.update(movie_params)
      render json: {name: movie.name, rating: movie.rating}, status: 200
    rescue ActiveRecord::RecordNotFound => e
      render json: {error: "Movie was not updated record not found."}, status: :not_found
    rescue StandardError => e
      e
    end
  end

  # delete
  def destroy
    movie = Movie.find_by(id: params[:id])
    if movie
      movie.destroy()
      render json: {message: "Movie has been successfully deleted."}, status: 200
    else
      render json: {error: "Movie was not found."}, status: 404
    end
  end

  private
    def movie_params
      params.require(:movie).permit(:name, :rating)
    end
end
