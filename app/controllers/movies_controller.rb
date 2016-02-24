class MoviesController < ApplicationController
  def index
    @movie = Movie.new
  end
end
