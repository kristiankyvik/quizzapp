var quiztitle ;
var currentquestion = 0,
    score = 0,
    submt = true,
    quiz,
    picked;


    $(document).ready(function(){

    function htmlEncode(value) {
        return $(document.createElement('div')).text(value).html();
    }
    var loadAudio = function (link){
      var response=null;
      var audio=document.getElementById('audio');
      var xhr =new XMLHttpRequest();
      xhr.open('GET', "https://api.spotify.com/v1/tracks/"+link);
      xhr.setRequestHeader('Accept', 'application/json'); //why accept

      xhr.onreadystatechange = function () {
          if (this.readyState === 4) {
            if (this.status === 200) {
              response = JSON.parse(this.response);
              audio.setAttribute('src', response.preview_url);
              audio.play();
            }
          }
        };
        xhr.send();
    };


    function addChoices(choices) {
        if (typeof choices !== "undefined" && $.type(choices) == "array") {
            $('#choice-block').empty();
            for (var i = 0; i < choices.length; i++) {
                $(document.createElement('li')).addClass('choice choice-box').attr('data-index', i).text(choices[i].title).appendTo('#choice-block');
            }
        }
    }

    function nextQuestion() {
        submt = true;
        $('#explanation').empty();
        loadAudio(quiz[currentquestion]['song']);
        $('#question').text(quiz[currentquestion]['question']);
        $('#pager').text('Question ' + Number(currentquestion + 1) + ' of ' + quiz.length);
        if (quiz[currentquestion].hasOwnProperty('image') && quiz[currentquestion]['image'] != "") {
            if ($('#question-image').length == 0) {
                $(document.createElement('img')).addClass('question-image').attr('id', 'question-image').attr('src', quiz[currentquestion]['image']).attr('alt', htmlEncode(quiz[currentquestion]['question'])).insertAfter('#question');
            } else {
                $('#question-image').attr('src', quiz[currentquestion]['image']).attr('alt', htmlEncode(quiz[currentquestion]['question']));
            }
        } else {
            $('#question-image').remove();
        }
        addChoices(quiz[currentquestion]['choices']);
        setupButtons();
    }


    function processQuestion(choice) {
        currentquestion++;
        $("#submitbutton").hide();
            if (currentquestion == quiz.length) {
                endQuiz();
            } else {     
                nextQuestion();
            }
    }
   function setupButtons() {
        $('.choice').on('mouseover', function () {
            $(this).css({
                'background-color': '#e1e1e1'
            });
        });
        $('.choice').on('mouseout', function () {
            $(this).css({
                'background-color': '#fff'
            });
        })
        $('.choice').on('click', function () {
            choice = $(this).attr('data-index');
            $('.choice').removeAttr('style').off('mouseout mouseover');
            $(this).css({
                'border-color': '#222',
                'font-weight': 700,
                'background-color': '#c1c1c1'
            });
            if (quiz[currentquestion]['choices'][choice].text === quiz[currentquestion]['correct']) {

            $('.choice').eq(choice).css({
                'background-color': '#50D943'
            });
            $('#explanation').html('<strong>Correct!</strong> ' + htmlEncode(quiz[currentquestion]['explanation']));
            score++;
        } else {
            $('.choice').eq(choice).css({
                'background-color': '#D92623'
            });
            $('#explanation').html('<strong>Incorrect.</strong> ' + htmlEncode(quiz[currentquestion]['explanation']));
        }
               $("#submitbutton").show();
            if (submt) {
                submt = false;
                $('#submitbutton').css({
                    'color': '#000'

                });
                $("#submitbutton").click(function(){
                     $('.choice').off('click');
                    $(this).off('click');
                    processQuestion(choice);
                });
            }
        })
    }


    function endQuiz() {
        $('#explanation').empty();
        $('#question').empty();
        $('#choice-block').empty();
        $('#submitbutton').remove();
        $('#question').text("You got " + score + " out of " + quiz.length + " correct.");
        $(document.createElement('h2')).css({
            'text-align': 'center',
            'font-size': '4em'
        }).text(Math.round(score / quiz.length * 100) + '%').insertAfter('#question');
    }



    function setupLayout () {
        $(document.createElement('h1')).text(quiztitle).appendTo('#frame');
        if (typeof quiz !== "undefined" && $.type(quiz) === "array") {
                //add pager
                $(document.createElement('p')).addClass('pager').attr('id', 'pager').text('Question 1 of ' + quiz.length).appendTo('#frame');
                //add first question
                $(document.createElement('h2')).addClass('question').attr('id', 'question').text(quiz[0]['question']).appendTo('#frame');
                //add image if present
                if (quiz[0].hasOwnProperty('image') && quiz[0]['image'] != "") {
                    $(document.createElement('img')).addClass('question-image').attr('id', 'question-image').attr('src', quiz[0]['image']).attr('alt', htmlEncode(quiz[0]['question'])).appendTo('#frame');
                }
                $(document.createElement('p')).addClass('explanation').attr('id', 'explanation').html('&nbsp;').appendTo('#frame');

                //questions holder
                $(document.createElement('ul')).attr('id', 'choice-block').appendTo('#frame');

                //add choices
                addChoices(quiz[0]['choices']);

                //add submit button
                $(document.createElement('div')).addClass('choice-box').attr('id', 'submitbutton').text('Check Answer').appendTo('#frame');

              $("#submitbutton").hide();
                setupButtons();

              loadAudio(quiz[0]['song']);
            }
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
                quiztitle = Object.keys(data);
                quiz = data[quiztitle];
                console.log(quiz);
              }
          }).done(function() {
              setupLayout();
            
          });

    }

    init();
});
