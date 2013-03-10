class LessonsController < ApplicationController
  
  # GET /library/:series_idlibrary/:series_id/lessons
  # GET /library/:series_id/lessons.json
  def index
    @lessons = Lesson.for_series(params[:series_id]).all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @lessons }
    end
  end

  # GET /library/:series_id/lessons/1
  # GET /library/:series_id/lessons/1.json
  def show
    @lesson = Lesson.for_series(params[:series_id]).find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @lesson }
    end
  end
  
end
