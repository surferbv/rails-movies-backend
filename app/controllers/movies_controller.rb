class MoviesController < ApplicationController
  def index
    movies = Movie.all
    render json: movies
end

def new
  render status: 501
end

def create
  render status: 501
end

def show
  movie = Movie.find(params[:id])
  render json: movie
end

def edit
  render status: :not_implemented
end

def update
  render status: 501
end

def destroy
  render status: 501
end

private
  def movie_params
    params.require(:movie).permit(:name, :rating)
  end
end
