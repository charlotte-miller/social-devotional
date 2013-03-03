class SeriesController < ApplicationController
  # caches_page :show

  # GET /series?search=keyword
  # GET /series.json
  def index
    @series = (
      if params[:search]
        Series.search do
          fulltext params[:search]
        end
        
      else # Not searching
        Series.all
      end
    )
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @series }
    end
  end

  # GET /series/1
  # GET /series/1.json
  def show
    @series = Series.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @series }
    end
  end

end
