class Sessions < Application

  def login
    request_token = @client.request_token
    session[:request_token] = request_token.token
    session[:request_token_secret] = request_token.secret
    redirect request_token.authorize_url 
  end

  def auth
    @access_token = @client.authorize(
      session[:request_token],
      session[:request_token_secret]
    )
    if @client.authorized?
      session[:access_token] = @access_token.token
      session[:secret_token] = @access_token.secret
      session[:user] = true
    end
    redirect '/'
  end

  def logout
    session[:user] = nil
    session[:request_token] = nil
    session[:request_token_secret] = nil
    session[:access_token] = nil
    session[:secret_token] = nil
    redirect '/' 
  end
end
