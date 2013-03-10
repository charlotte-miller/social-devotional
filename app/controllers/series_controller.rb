class SeriesController < ApplicationController
  # caches_page :show

  # GET /library?search=keyword
  # GET /library.json
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

  # GET /library/1
  # GET /library/1.json
  def show
    @series = Series.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @series }
    end
  end

end
