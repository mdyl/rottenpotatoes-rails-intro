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
    if params[:ratings] == nil
      if session[:ratings] != nil
        redirect_to :action => 'index', :sort => @sort, :ratings => session[:ratings]
      else
        params[:ratings] = Movie.start_ratings
      end
    end

    @selected_ratings = (params[:ratings].present? ? params[:ratings] : [])
    
    if params[:sort] != nil || session[:sort] != nil
      @sort = params[:sort] || session[:sort]
      session[:sort] = @sort
      if @selected_ratrings != nil
        #@check_box_tag = @selected_rankings
        #flash[:notice] = @check_box_tag
        session[:ratings] = @selected_ratings
        @movies = Movie.where(:rating => @selected_ratings.keys).order @sort
      end
    else
      if @selected_ratings != nil
        session[:ratings] = @selected_ratings
        @movies = Movie.where(:rating => @selected_ratings.keys)
      else
        @movies = Movie.all
      end
    end
   
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
