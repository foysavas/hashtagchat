class Chats < Application

  def index
    @tag = 'hashtagchat'
    @tag = params[:tag] if params[:tag]
    session[:tag] = @tag
    render
  end

end
