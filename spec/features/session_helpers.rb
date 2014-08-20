
def sign_up_with(email, password)
    fill_in 'Email', with: email
    fill_in 'Password', with: password
    fill_in 'Password confirmation', with: password
    click_button 'Sign up'
end

def sign_in_with(email, password)
  fill_in 'Email', with: email
  fill_in 'Password', with: password
  click_button 'Sign in'
end

def create_test_quiz ()
  user = User.create(email:'test@test.com', password: 'testpassword')
  quiz = Quiz.create(title: "test quiz title", user: user)
  question=Question.create(
    title: "test question title",
    song: "65rRB2mspD309xE6YimZTl",
    quiz_id: quiz.id)
  Choice.create(title: "test answer 1", question_id:question.id, correct: true)
  Choice.create(title: "test answer 2", question_id:question.id)
  Choice.create(title: "test answer 3", question_id:question.id)
  Choice.create(title: "test answer 4", question_id:question.id)
end