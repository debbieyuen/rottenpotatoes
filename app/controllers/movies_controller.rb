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
    
    byebug 
    @sort_by = params[:sort_by]
    #it stores it as a cookie 
    if @sort_by
      session[:sort_by] = @sort_by
    end
    
    #when you get it back from the session
    @sort_by = session[:sort_by]
    #delete that session because user is doing something else 
    #session[:sort_by].delete
     
    #set it as a session cookie again for ratings
    if !params[:ratings].nil?
        session[:ratings] = params[:ratings]
    else
        params[:ratings] = Movie.all_ratings
    end
    
    @some_var = (session[:sort_by].eql?( "title")) ? "hilite p-3 mb-2 bg-warning": "None" 
    @some_rating = (session[:sort_by].eql?( "rating")) ? "hilite p-3 mb-2 bg-warning": "None" 
    @some_release = (session[:sort_by].eql?("release_date")) ? "hilite p-3 mb-2 bg-warning": "None" 
    if session[:ratings]
      puts "session"
      puts session[:ratings]
      puts params[:ratings]
      
      if(params[:ratings].is_a?(Hash))
        session[:ratings] = params[:ratings].keys
      else
        session[:ratings] = params[:ratings]
      end
      
      @movies = Movie.with_ratings(session[:ratings]).order(session[:sort_by])
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
