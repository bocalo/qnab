require 'rails_helper'

feature 'User can see the question and answers to it', %q{
  In order to get answer from a community
  As an authentecated user
  I'd like to be able to see the question and answers to it
} do
  given(:user) { create(:user) }
  given!(:question) { create(:question, user: user) }
  given!(:answers) { create_list(:answer, 3, question: question, user: user) }

  background { visit question_path(question) }

  scenario 'Authenticated user can see question and answers to it' do
    sign_in(user)
    expect(page).to have_content question.title
    expect(page).to have_content question.body
    answers.each { |answer| expect(page).to have_content question.body }
  end

  scenario 'Unauthenticated user can see question and answers to it' do
    expect(page).to have_content question.title
    expect(page).to have_content question.body
    answers.each { |answer| expect(page).to have_content question.body }
  end
end