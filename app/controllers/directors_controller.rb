class DirectorsController < ApplicationController

  def create
    d = Director.new
    d.name = params.fetch("the_name")
    d.dob =params.fetch("the_dob")
    d.bio = params.fetch("the_bio")
    d.image = params.fetch("the_image")

    d.save

    redirect_to("/directors")
  end

  def destroy
    director_id = params.fetch("an_id")
    matching_records = Director.where({ :id => director_id})
    the_director = matching_records.at(0)
    the_director.destroy

    redirect_to("/directors")
  end

  def update

    # {"the_name"=>"John Crowleysdsa", "the_dob"=>"", "the_bio"=>"John Crowley (born 1969) is an Irish award-winning television director, theatre and film director. He is perhaps best known for his feature film debut Intermission (2003).", "the_image"=>"https://image.tmdb.org/t/p/w500/2s24bopQ131ZTF3lrBLRFKMHPQG.jpg", "an_id"=>"77269"}

    d_id = params.fetch("an_id")
    matching_records = Director.where({ :id => d_id})
    the_director = matching_records.at(0)

    the_director.name = params.fetch("the_name")
    the_director.dob =params.fetch("the_dob")
    the_director.bio = params.fetch("the_bio")
    the_director.image = params.fetch("the_image")

    the_director.save

    redirect_to("/directors/#{d_id}")
  end



  def index
    matching_directors = Director.all
    @list_of_directors = matching_directors.order({ :created_at => :desc })

    render({ :template => "director_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_directors = Director.where({ :id => the_id })
    @the_director = matching_directors.at(0)

    render({ :template => "director_templates/show" })
  end

  def max_dob
    directors_by_dob_desc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :desc })

    @youngest = directors_by_dob_desc.at(0)

    render({ :template => "director_templates/youngest" })
  end

  def min_dob
    directors_by_dob_asc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :asc })
      
    @eldest = directors_by_dob_asc.at(0)

    render({ :template => "director_templates/eldest" })
  end
end
