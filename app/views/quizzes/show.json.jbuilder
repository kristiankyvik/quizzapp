json.set! @quiz.title do
  json.array! @quiz.questions do |q|
    json.question_title q.title
    json.song q.song
    json.choices q.choices
  end
end
    