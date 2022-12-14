class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  
  expose :questions, ->{ Question.all }
  expose :question

  def index
    @questions = Question.all
  end

  def show
    @answer = question.answers.new
  end

  def create
    @question = current_user.questions.new(question_params)
    if @question.save
      redirect_to @question, notice: 'Your question successfully created.'
    else
      render :new
    end
  end

  def update
    if question.update(question_params)
      redirect_to question
    else
      render :edit
    end
  end

  def destroy
    if current_user.author?(question)
      question.destroy
      redirect_to questions_path, notice: 'Question successfully deleted.'
    else
      redirect_to questions_path, notice: 'You have no rights to delete this question.'
    end
    
  end

  private

  def question
     @question ||= params[:id] ? Question.find(params[:id]) : Question.new
  end

  helper_method :question

  def question_params
    params.require(:question).permit(:title, :body)
  end
end
