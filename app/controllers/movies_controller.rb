class MoviesController < ApplicationController
  def index; end

  def new; end

  def create
    @movie_title = params[:movie_title]
    if @movie_title.empty?
      flash.now[:error] = 'Oops, nothing to search!'
      render :index
    elsif @movie_title.match(/[\p{L}&&[^a-zA-Z]]/)
      flash.now[:error] = 'Please, use only ASCII characters.'
      render :index
    else
      parser = ParserService.new
      parser.find_movie(@movie_title)
      parser_result = parser.result

      if parser_result['Title'].nil?
        flash.now[:error] = "Sorry, but there is no results for \"#{@movie_title}\"."
        render :index

      else
        @movie = ShowFilm.new(parser.prepare_to_model)
        render :show
      end
    end
  end
end
