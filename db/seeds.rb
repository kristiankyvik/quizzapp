user = User.create(email:'test@test.com', password: 'testpassword')
quiz = Quiz.create(title: "rap-test", user: user)


question1=Question.create(
  title: "what is the name of the song?",
  song: "65rRB2mspD309xE6YimZTl",
  quiz: quiz)

Choice.create(title: "Money of my mind",question:question1)
Choice.create(title: "Click", question:question1)
Choice.create(title: "Too Pain", question:question1)
Choice.create(title: "yeuuuu", question:question1)

