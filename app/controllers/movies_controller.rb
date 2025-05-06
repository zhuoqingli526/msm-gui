class MoviesController < ApplicationController
  def index
    matching_movies = Movie.all
    @list_of_movies = matching_movies.order({ :created_at => :desc })

    render({ :template => "movie_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_movies = Movie.where({ :id => the_id })
    @the_movie = matching_movies.at(0)

    render({ :template => "movie_templates/show" })
  end


  def create
    # Retrieve the user's inputs from params
    # Parameters: {"the_title"=>"d", "the_year"=>"w", "the_duration"=>"q", "the_description"=>"2", "the_image"=>"w", "the_director_id"=>"2"}
    # Create a record in the movie table
    # populate each column with the user input
    # Save

    # redirect the user back to the /movies URL
    the_movie = Movie.new
    the_movie.title = params.fetch("the_title")
    the_movie.year = params.fetch("the_year")
    the_movie.duration = params.fetch("the_duration")
    the_movie.description = params.fetch("the_description")
    the_movie.image = params.fetch("the_image")
    the_movie.director_id = params.fetch("the_director_id")

    the_movie.save

    redirect_to("/movies")

  end

  def destroy
    # Retrieve the user's inputs from params
    # Parameters: {"the_title"=>"d", "the_year"=>"w", "the_duration"=>"q", "the_description"=>"2", "the_image"=>"w", "the_director_id"=>"2"}
    # Create a record in the movie table
    # populate each column with the user input
    # Save

    # redirect the user back to the /movies URL
    the_id = params.fetch("an_id")

    matching_records = Movie.where({ :id => the_id})

    the_movie = matching_records.at(0)

    the_movie.destroy

    redirect_to("/movies")
  end

  def update
    # Get the ID out of params
    m_id = params.fetch("an_id")

    # Look up the existing record
    matching_records = Movie.where({ :id => m_id})
    the_movie = matching_records.at(0)

    # Overwrite each column with the values from user inputs
    the_movie.title = params.fetch("the_title")
    the_movie.year = params.fetch("the_year")
    the_movie.duration = params.fetch("the_duration")
    the_movie.description = params.fetch("the_description")
    the_movie.image = params.fetch("the_image")
    the_movie.director_id = params.fetch("the_director_id")

    # Save
    the_movie.save

    # Redirect
    redirect_to("/movies/#{the_movie.id}")
  end
end
