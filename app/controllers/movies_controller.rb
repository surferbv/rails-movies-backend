class MoviesController < ApplicationController
  # get
  def index
    movies = Movie.all
    render json: movies
  end
  
  # get
  # responsible for rendering the view before create
  def new
    render status: 501 
  end

  # post
  # format { "name": "acme", "raiting": "10" }
  def create
    # .create! is equivalent to .new followed by .save! (throws an error if saving fails). It's also just a wee bit shorter
    # Movie.create!(params[:movie])
    # render json: {message: "Movie was created successfully."}, status: :created

    movie = Movie.new(params[:movie])
    if movie
      movie.save!
      render json: {message: "Movie was created successfully."}, status: :created
    else
      render json: {error: "Movie failed to be created."}, status: :internal_server_error
    end
  end

  # get
  def show
    movie = Movie.find(params[:id])
    render json: movie
  end

  # get
  # responsible for rendering the view before update
  def edit
    render status: :not_implemented
  end

  # put
  # responsible for updating the existing record
  # format { "name": "acme", "raiting": "10" }
  def update
    movie = Movie.find(params[:id])
    if movie
      movie.update(movie_params)
      render json: {message: "Movie successfully updated."}, status: 200
    else
      render json: {error: "Movie was not updated."}, status: 400
    end
  end

  # delete
  def destroy
    movie = Movie.find(params[:id])
    if movie
      movie.destroy()
      render json: {message: "Movie has been successfully deleted."}, status: 200
    else
      render json: {error: "Movie was not deleted."}, status: 400
    end
  end

  private
    def movie_params
      params.require(:movie).permit(:name, :rating)
    end
end
