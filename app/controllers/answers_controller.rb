class AnswersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :set_question, :only => [:index, :create]#, :unless => format_json?
  
  # GET questions/:id/answers
  # GET questions/:id/answers.json
  def index
    @answers = Answer.where(question_id:params[:question_id]).all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @answers }
    end
  end

  # GET /answers/1
  # GET /answers/1.json
  def show
    @answer = Answer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @answer }
    end
  end

  # POST questions/:id/answers
  # POST questions/:id/answers.json
  def create
    @answer = Answer.new(params[:answer])
    merge_author_and_question

    respond_to do |format|
      if @answer.save
        format.html { redirect_to @answer, notice: 'Answer was successfully created.' }
        format.json { render json: @answer, status: :created, location: @answer }
      else
        format.html { render action: "show", status: :unprocessable_entity }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /answers/1
  # PUT /answers/1.json
  def update
    @answer = Answer.find(params[:id])
    merge_author_and_question

    respond_to do |format|
      if @answer.update_attributes(params[:answer])
        format.html { redirect_to @answer, notice: 'Answer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "show", status: :unprocessable_entity }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /answers/1
  # DELETE /answers/1.json
  def destroy
    @answer   = Answer.includes(:question).find(params[:id])
    @question = @answer.question
    @answer.destroy

    respond_to do |format|
      format.html { redirect_to question_answers_url(@question) }
      format.json { head :no_content }
    end
  end
  
  # POST /answers/1/block
  # POST /answers/1/block.json
  def block
    @question      = Question.find(params[:id])
    @block_request = BlockRequest.new(source: @question)
    
    respond_to do |format|
      if @block_request.save
        format.html { redirect_to @block_request, notice: 'Answer Blocked.' }
        format.json { render json: @block_request, status: :created, location: @block_request }
      else
        format.html { render action: "new" }
        format.json { render json: @block_request.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # POST /answers/1/star
  # POST /answers/1/star.json
  def star
    @star = Star.create({
      user_id: current_user.id,
      source:  current_source
    })
    
    respond_to do |format|
      if @star.save
        format.html { redirect_to @star, notice: 'Answer Stared.' }
        format.json { render json: @star, status: :created, location: @star }
      else
        format.html { render action: "new" }
        format.json { render json: @star.errors, status: :unprocessable_entity }
      end
    end
  end
  
private

  def set_question
    @question = Question.find(params[:question_id])
  end
  
  def merge_author_and_question
   @answer.author      = current_user
   @answer.question_id = params[:question_id] if @answer.new_record?
  end
  
end
