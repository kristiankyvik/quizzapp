var quiztitle ;
var currentquestion = 0,
    score = 0,
    cansubmit = true,
    quiz,
    picked,
    timer;

    $(document).ready(function(){

    function htmlEncode(value) {
        return $(document.createElement('div')).text(value).html();
    }

    var loadAudio = function (link){
      $.ajax({
              url: "https://api.spotify.com/v1/tracks/"+link,
              type: 'GET',
              crossDomain : true,
              xhrFields: {
          },
              success: function(data) {
                audio.setAttribute('src', data.preview_url);
                audio.play();
              }
          })
    };

    function setupLayout () {
      $('<h1/>').text(quiztitle).appendTo('#frame');
      $('<p/>').addClass('questionCounterBanner').attr('id', 'questionCounterBanner').text('Question 1 of ' + quiz.length).appendTo('#frame');
      $('<p/>').addClass('question').attr('id', 'question').text(quiz[0]['question_title']).appendTo('#frame');
      $('<img/>').addClass('question-image').attr('id', 'question-image').attr('src', quiz[0]['image']).attr('alt', htmlEncode(quiz[0]['question'])).appendTo('#frame');
      $('<p/>').addClass('explanation').attr('id', 'explanation').html('&nbsp;').appendTo('#frame');
      $('<ul/>').attr('id', 'choice-block').appendTo('#frame');
      addChoices(quiz[0]['choices']);
      $('<div/>').addClass('choice-box').attr('id', 'nextButton').text('NextQuestion').appendTo('#frame').hide();
      setupButtons();   
    }

    function addChoices(choices) { 
      $('#choice-block').empty();
      for (var i = 0; i < choices.length; i++) {
          $('<li/>').addClass('choice choice-box').attr('data-index', i).text(choices[i].title).appendTo('#choice-block');
      }
    }

    function setupButtons() {
      $('.choice').on('click', function () {
          clearAlert()
          choice = $(this).attr('data-index');
          console.log(choice);
          console.log(currentquestion);
          console.log(quiz[currentquestion]['choices'][choice].title + "sasasa" + quiz[currentquestion]['choices']['correct']);


          if (quiz[currentquestion]['choices'][choice].correct) {
              $('#explanation').html('<strong>Correct!</strong> ' + htmlEncode(quiz[currentquestion]['explanation']));
              score++;
          } else {
          $('#explanation').html('<strong>Incorrect.</strong> ' + htmlEncode(quiz[currentquestion]['explanation']));
          }
          $("#nextButton").show();
          if (cansubmit) {
              cansubmit = false;
              $("#nextButton").click(function(){
                   $('.choice').off('click');
                  $(this).off('click');
                  upCounter();
              });
          }
      })
    }

    function showTimeoutBox () {
      $('#myModal').modal({show:true})
      clearAlert();
      $("#next-question-modal").click(function(){
          console.log("clickkkk modall")
          $('.choice').off('click');
          $(this).off('click');
          upCounter();
      });
    }

    function clearAlert() {
      window.clearTimeout(timer);
      console.log("alert cleared!!!");
    }

    function upCounter() {
        currentquestion++;
        $("#nextButton").hide();
            if (currentquestion == quiz.length) {
                endQuiz();
            } else {     
                nextQuestion();
            }
    }

    function nextQuestion() {
        cansubmit = true;
        $('#explanation').empty();
        loadAudio(quiz[currentquestion]['song']);
        $('#question').text(quiz[currentquestion]['question']);
        $('#questionCounterBanner').text('Question ' + Number(currentquestion + 1) + ' of ' + quiz.length);  
        $('#question-image').attr('src', quiz[currentquestion]['image']).attr('alt', htmlEncode(quiz[currentquestion]['question']));
        addChoices(quiz[currentquestion]['choices']);
        setupButtons();
        timer = window.setTimeout(showTimeoutBox, 8000)
    }

    function endQuiz() {
        $('#explanation').empty();
        $('#question').empty();
        $('#choice-block').empty();
        $('#nextButton').remove();
        $('#question').text("You got " + score + " out of " + quiz.length + " correct.");
        $('h2').text(Math.round(score / quiz.length * 100) + '%').insertAfter('#question');
    }

    function init() {
        $.ajax({
              url: "http://localhost:3000/users/1/quizzes/1.json",
              type: 'GET',
              crossDomain : true,
              xhrFields: {
              withCredentials: true
          },
              success: function(data) {
              }
          }).done(function(data) {
            quiztitle = Object.keys(data);
            quiz = data[Object.keys(data)];
            console.log(quiz)
            setupLayout();
            loadAudio(quiz[0].song);
            timer = window.setTimeout(showTimeoutBox, 8000);
          });

    }

    init();
});
