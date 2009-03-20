class Posts < Application

  def create
    hashtag = "##{session[:tag]}"
    hashtag = "##{params[:tag]}" if params[:tag]
    message = params[:message]
    length = hashtag.length + 1
    if message.length > (140-length)
      message = message[0..(140-length)] + " " + hashtag
    else
      message = message + " " + hashtag
    end
    @client.update(message)
    redirect '/'
  end

end
