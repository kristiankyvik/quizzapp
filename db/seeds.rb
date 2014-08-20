user = User.create(email:'test@test.com', password: 'testpassword')
quiz = Quiz.create(title: "rap-test", user: user)


question=Question.create(
  title: "what is the name of the song?",
  song: "65rRB2mspD309xE6YimZTl",
  quiz_id: quiz.id)

Choice.create(title: "Money of my mind", question_id:question.id, correct: true)
Choice.create(title: "Click", question_id:question.id)
Choice.create(title: "Too Pain", question_id:question.id)
Choice.create(title: "yeuuuu", question_id:question.id)

