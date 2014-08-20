
var loadSearch=function(link){
  var xhr =new XMLHttpRequest();
  xhr.open('GET', "https://api.spotify.com/v1/search/?q="+link);
  xhr.setRequestHeader('Accept', 'application/json');
  xhr.onreadystatechange = function () {
      if (this.readyState === 4) {
        if (this.status === 200) {
          response = JSON.parse(this.response);
          console.log(response);
          putResults(response.tracks.items);
          var results=document.querySelector("#results");
          
          results.addEventListener('click',function(evt){
            evt.preventDefault();
            var selected=evt.target;
            //If the user click on the song name or author name we have to get the url from <a></a>
            if(evt.target.nodeName!=="A")
              console.log("link clicked")
              selected=evt.target.parentNode;
              var name = $(selected).find('.song')[0].innerHTML;
              console.log(name);
              var field = $("#question_song")[0];
              field.value = selected.id;
              document.getElementById("chosenSong").innerHTML = name;

          });
        }
      }
    };


  xhr.send();
};

var parseSearch=function(query){
  var newValue="";
  for(var i=0;i<query.length;i++){
    if(query[i]==" ")
      newValue+="%20";
    else
      newValue+=query[i];
  }
  return newValue;
};

var setProgress=function(audio,progress){
  var ratio=30/audio.duration;
  var progressValue=Math.floor(ratio*audio.currentTime);
  progress.value=progressValue;
}

document.addEventListener('submit', function (evt){
      if(evt.target.id==='search'){
      evt.preventDefault();
      var words= evt.target.searchItem.value;
      words+="&type=track";
      link=parseSearch(words);
      loadSearch(link);
    }

});
var putResults=function(object){
  var ul=document.querySelector("#results");
  //First we have to remove previous searches
  while(ul.hasChildNodes()){
    ul.removeChild(ul.firstChild);
  }
  for(var key in object){
    var artist=document.createElement("span");
    var song=document.createElement("span");
    var li=document.createElement("li");
    var a=document.createElement("a");
    artist.className="artist";
    song.className="song";
    artist.textContent=object[key].artists[0].name;
    song.textContent=object[key].name;
    a.id=object[key].id;
    a.appendChild(artist);
    a.appendChild(song);
    li.appendChild(a);
    ul.appendChild(li);
  }

}
