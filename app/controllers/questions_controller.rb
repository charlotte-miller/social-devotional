class QuestionsController < ApplicationController
  include SourceableControllers
  
  before_filter :authenticate_user!
  before_filter :merge_author_and_source, only: [:create, :update, :destroy]
  
  # GET /questions
  # GET /questions.json
  def index
    @questions = Question.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @questions }
    end
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
    @question = Question.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @question }
    end
  end

  # GET /questions/new
  # GET /questions/new.json
  def new
    @question = Question.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @question }
    end
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = Question.new(params[:question])

    respond_to do |format|
      if @question.save
        format.html { redirect_to @question, notice: 'Question was successfully created.' }
        format.json { render json: @question, status: :created, location: @question }
      else
        format.html { render action: "new" }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  
  # POST /questions/1/block
  # POST /questions/1/block.json
  def block
    @question      = Question.find(params[:id])
    @block_request = BlockRequest.new(source: @question)
    
    respond_to do |format|
      if @block_request.save
        format.html { redirect_to @block_request, notice: 'Question Blocked.' }
        format.json { render json: @block_request, status: :created, location: @block_request }
      else
        format.html { render action: "new" }
        format.json { render json: @block_request.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # POST /questions/1/star
  # POST /questions/1/star.json
  def star
    @star = Star.create({
      user_id: current_user.id,
      source:  current_source
    })
    
    respond_to do |format|
      if @star.save
        format.html { redirect_to @star, notice: 'Question Stared.' }
        format.json { render json: @star, status: :created, location: @star }
      else
        format.html { render action: "new" }
        format.json { render json: @star.errors, status: :unprocessable_entity }
      end
    end
  end
  
private
  
  def merge_author_and_source
    params[:question][:author] = current_user
    params[:question][:source] = current_source
  end
  
  def current_source
    def find_obj
      return Lesson.find(  params.delete(:lesson_id)  ) if params[:lesson_id]
      return Meeting.find( params.delete(:meeting_id) ) if params[:meeting_id]
    end
    @current_source ||= find_obj
  end
  
end
