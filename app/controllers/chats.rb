class Chats < Application

  def index
    if params[:tag]
      @tag = params[:tag]
    elsif session[:tag]
      @tag = session[:tag]
    else
      @tag = 'hashtagchat'
    end
    session[:tag] = @tag
    render
  end

end
