class Application < Merb::Controller
  
  before :setup

  def setup
    @user = session[:user]
    @client = TwitterOAuth::Client.new(:token => session[:access_token], :secret => session[:secret_token])
  end

  private

  def twitter_auth_url
    @client.request_token.authorize_url
  end

end
