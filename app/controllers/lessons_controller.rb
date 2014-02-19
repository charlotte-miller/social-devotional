class LessonsController < ApplicationController
  
  # GET /library/:studies_idlibrary/:studies_id/lessons
  # GET /library/:studies_id/lessons.json
  def index
    @study   = Study.includes(:lessons, :church).find(params[:study_id])
    @lessons = @study.lessons
    raise ActiveRecord::RecordNotFound if @lessons.empty?
    
    # Users last watched or... for now
    @lesson = @lessons.first
    
    respond_to do |format|
      format.html { redirect_to [@study, @lesson] }
      format.json { render json: @lessons }
    end
  end

  # GET /library/:studies_id/lessons/1
  # GET /library/:studies_id/lessons/1.json
  def show  
    @study   = find_or_redirect_to_study || return #redirecting 
    @church  = @study.church
    @lessons = @study.lessons
    raise ActiveRecord::RecordNotFound if @lessons.empty?
    
    @lesson = Lesson.w_questions.find(params[:id])
    
    @video      = @lesson.video
    @questions  = @lesson.questions.includes(:answers)
    @q_popular  = @lesson.questions.popular
    @q_recent   = @lesson.questions.recent
    @q_timeline = @lesson.questions.timeline

    respond_to do |format|
      format.html # show.html.erb }
      format.json { render json: @lesson }
    end
  end
  
private

  # Return @study OR follow old friendly_id
  # Usage: @study = find_or_redirect_to_study || return #redirecting
  def find_or_redirect_to_study
    study = Study.w_lessons.find(params[:study_id]) 
    unless !!(%r{#{study_path(study)}/} =~ request.path)
      redirect_to( study_lesson_url(study, params[:id]), status: :moved_permanently ) && (return false)
    end
    return study
  end
end
