class DirectorsController < ApplicationController
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

   def create
     the_name  = params.fetch("the_director")
     the_dob   = params.fetch("query_dob")
     the_bio   = params.fetch("bio_box")
     the_image = params.fetch("image_box")

     new_director = Director.new
     new_director.name  = the_name
     new_director.dob   = the_dob
     new_director.bio   = the_bio
     new_director.image = the_image
     new_director.save

     redirect_to("/directors")
   end
   
   def destroy
    the_id = params.fetch("an_id")

    matching_records = Director.where({ :id => the_id })

    the_director = matching_records.at(0)

    the_director.destroy

    redirect_to("/directors")

   end

    def update
      the_id = params.fetch("the_id")

      matching_records = Director.where({ :id => the_id})
      the_director = matching_records.at(0)

            

     the_director.name  = params.fetch("the_director")
     the_director.dob   = params.fetch("query_dob")
     the_director.bio   = params.fetch("bio_box")
     the_director.image = params.fetch("image_box")

     the_director.save


      redirect_to("/directors/#{the_director.id}")
  end
end
