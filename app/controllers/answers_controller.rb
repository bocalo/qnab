class AnswersController < ApplicationController
  before_action :authenticate_user!, except: %i[new]

  expose :question, ->{ Question.find(params[:question_id]) }
  expose :answer
  
  def create
    @answer = question.answers.new(answer_params)
    @answer.user = current_user
    
    if @answer.save
      redirect_to question, notice: 'Your answer was successfully created.'
    else
      render 'questions/show'
    end
  end

  def destroy
    if current_user&.author?(answer)
      answer.destroy
      redirect_to question_path(answer.question), notice: 'Answer was successfully deleted.'
    else
      redirect_to question_path(answer.question), notice: 'You have no rights to delete the answer.'
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end
end
