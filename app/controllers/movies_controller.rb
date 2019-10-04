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
    @all_ratings = Movie.all_ratings
    
    
    if params.has_key?  "ratings"
      @ratings = params[:ratings]
      session[:ratings] = params[:ratings]
    elsif session.has_key? "ratings"
      @ratings = session[:ratings]
      flash[:notice] = "Test 1"
    else 
      @ratings = nil
    end
      
    
    if params.has_key? "sort_by"
      @sort_by = params[:sort_by]
      session[:sort_by] = @sort_by
    elsif session.has_key? "sort_by"
      @sort_by = session[:sort_by]
    else
      @sort_by = nil
    end

    
    if @ratings.nil?
      if @sort_by.nil?
        @movies = Movie.all
      else 
        @movies = Movie.order("#{@sort_by} asc")
      end
    else
      if @sort_by.nil?
        @movies = Movie.where(rating: @ratings.keys)
      else
        @movies = Movie.where(rating: @ratings.keys).order("#{@sort_by} asc")
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

end
