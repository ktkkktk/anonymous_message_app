class SessionsController < ApplicationController
  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      if @user.activated?
        log_in @user
        redirect_to @user
      else
        message = "アカウントが有効化されていません。"
        message += "登録したメールを確認し、アカウントを有効化してください。"
        flash[:warning] = message
        redirect_to root_url
      end
    else
      flash[:danger] = 'ログインできませんでした'
      redirect_to root_url
    end
  end
  
  def destroy
    session.delete(:user_id)
    @current_user = nil
    if request.referrer == root_url
      redirect_to user_path(1)
    else
      redirect_to root_url
    end
  end
  
end
