class LessonsController < ApplicationController
  
  # GET /library/:studies_idlibrary/:studies_id/lessons
  # GET /library/:studies_id/lessons.json
  def index
    @lessons = Lesson.for_studies(params[:study_id]).all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @lessons }
    end
  end

  # GET /library/:studies_id/lessons/1
  # GET /library/:studies_id/lessons/1.json
  def show
    @lesson = Lesson.for_study(params[:study_id]).find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @lesson }
    end
  end
  
end
