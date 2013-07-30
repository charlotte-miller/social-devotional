class StudiesController < ApplicationController
  # caches_page :show

  # GET /library?search=keyword
  # GET /library.json
  def index
    @studies = (
      if params[:search]
        Study.search do
          fulltext params[:search]
        end
        
      else # Not searching
        Study.all
      end
    )
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @studies }
    end
  end

  # GET /library/1
  # GET /library/1.json
  def show
    @study      = find_or_redirect_to_study || return #redirecting
    @lessons    = @study.lessons
    @lesson     = @lessons.first
    @video      = @lesson.video
    # @questions  = @lesson.questions
    @q_popular  = @lesson.questions.popular
    @q_recent   = @lesson.questions.recent
    @q_timeline = @lesson.questions.timeline
    
      
    respond_to do |format|      
      format.html # show.html.erb
      format.json { render json: @study }
    end
  end

private
  
  # Return @study OR follow old friendly_id
  # Usage: @study = find_or_redirect_to_study || return #redirecting
  def find_or_redirect_to_study
    study = Study.w_lessons.find(params[:id]) 
    unless request.path == study_path(study)
      redirect_to( study, status: :moved_permanently ) && (return false)
    end
    return study
  end
  
end
