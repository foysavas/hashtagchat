class Posts < Application

  def create
    message = params[:message]
    if params[:quietly]
      message = "@q " + message
    end
    hashtag = "##{session[:tag]}"
    hashtag = "##{params[:tag]}" if params[:tag]
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
