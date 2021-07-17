class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    #call functions
    # will render app/views/movies/show.<extension> by default
  end

  def index
     
     if params[:ratings].nil?
      @ratings_to_show = Movie.all_ratings
     else 
      @ratings_to_show = params[:ratings]
     end
    
    @sort_by = params[:sort_by]
    
    @some_var = @sort_by ? "hilite p-3 mb-2 bg-warning": "None" 
    if params[:ratings]
      @movies = Movie.with_ratings(params[:ratings]).order(@sort_by)
      #.order picks all the movies. it will order them in a correct way. get it from the views
       #params sort by params[:sort_by] and get information 
      #use movies_path make a call to your data base @movie = Movie.order
      #plug this information into order 
      #tell data base to go to Movie data base and call which method on it. And whatver methods
      #gives you, which is going to be a collection of movies. Now order them by what i specify
    else
      @movies = Movie.all
    end
    @all_ratings = Movie.all_ratings
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

  private
  # Making "internal" methods private is not required, but is a common practice.
  # This helps make clear which methods respond to requests, and which ones do not.
  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end
end