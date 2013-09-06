class LessonsController < ApplicationController
  
  # GET /library/:studies_idlibrary/:studies_id/lessons
  # GET /library/:studies_id/lessons.json
  def index
    @study   = Study.includes(:lessons).find(params[:study_id])
    @lessons = @study.lessons.all
    raise ActiveRecord::RecordNotFound if @lessons.empty?

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @lessons }
    end
  end

  # GET /library/:studies_id/lessons/1
  # GET /library/:studies_id/lessons/1.json
  def show
    @study   = Study.find(params[:study_id])
    @lessons = @study.lessons.all
    raise ActiveRecord::RecordNotFound if @lessons.empty?

    @lesson = Lesson.w_questions.find(params[:id])
    # lesson_number = params[:id].to_i
    # lesson_number = (lesson_number > @lessons.count) ? 0 : lesson_number-1
    # @lesson  = @lessons[ lesson_number ]
    
    @questions = @lesson.questions

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @lesson }
    end
  end
  
end
