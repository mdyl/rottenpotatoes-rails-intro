class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = Movie.movie_ratings
    @sort = params[:sort] || session[:sort]
    if params[:ratings] == nil
      if session[:ratings] != nil
        redirect_to :action => 'index', :sort => params[:sort] || session[:sort], :ratings => session[:ratings]
      else
        params[:ratings] =  {'G' => 'G', 'PG' => 'PG', 'PG-13' => 'PG-13', 'R' => 'R'}
      end
    end

    @selected_rankings = (params[:ratings].present? ? params[:ratings] : session[:ratings])
    session[:ratings] = @selected_rankings
    session[:sort] = @sort
    @movies = Movie.where(:rating => @selected_rankings.keys).order @sort    
   
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

  def hilited

  end

end
