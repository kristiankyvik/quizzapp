json.set! @quiz.title do
  json.array! @quiz.questions do |q|
    json.question q.title
    json.song q.song
    json.choices q.choices
    json.explanation q.explanation
  end
end
    