var tag = 'hashtagchat';
var interval = 5000;
var since_id = 0;

$(document).ready(function() {
  tag = $('#tag').html(); 
  update_chat();
  $.timer(interval, function(t) {
    update_chat();
  });
  $('#chat_form').submit(function(){
    tag = $('#chat_form_tag_field').val();
    $('#chat').html('');
    $('#tag').html(tag);
    $('#post_form_tag_field').val(tag);
    since_id = 0;
    update_chat();
    return false;
  });
});

function update_chat() {
  find_new_tweets();
}

function clean_tweet(tweet) {
  return tweet;
}


function twitter_avatar(tweet) {
  r =  "<div class='avatar'><a target='_blank' href='http://www.twitter.com/"+tweet.from_user+"'>";
  r += "<img src='"+tweet.profile_image_url+"' />";
  r += "</a></div>";
  return r;
}

function twitter_msg(tweet) {
  r =  "<div class='msg'><a target='_blank' href='http://www.twitter.com/"+tweet.from_user+"'>"+tweet.from_user+"</a>: ";
  r += "<span class='msgtxt'>"+clean_tweet(tweet.text)+"</span>";
  r += "</div>";
  return r;
}

function twitter_info(tweet) {
  r =  "<div class='info'>";
  r += $.timeago(new Date(tweet.created_at));
  r += "</div>";
  return r;
}

function handle_new_tweets(twitter_json) {
  for(i=twitter_json.results.length-1;i>-1;i--) {
    tweet = twitter_json.results[i];
    $('#chat').prepend("<div class='message'>"+twitter_avatar(tweet)+twitter_msg(tweet)+twitter_info(tweet)+"</div>");
    since_id = tweet['id'];    
  }
}     



function find_new_tweets() {
  url = "http://search.twitter.com/search.json?q=%23" + tag;
  if(since_id > 0) {
    url += "&since_id="+since_id;
  }
  url += "&callback=?";
  $.getJSON(url,function(data){
    handle_new_tweets(data)
  });
}
