module ApplicationHelper
  
  def require_login
    unless current_user
      redirect_to root_url
      flash[:error] = "ログインしてください"
    end
  end
  
  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end
  
  def logged_in?
    !current_user.nil?
  end
end
