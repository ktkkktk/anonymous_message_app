class SessionsController < ApplicationController
  def create
    @user = User.find_by(email: params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      redirect_to @user
    else
      flash[:error] = 'ログインできませんでした'
      redirect_to root_url
    end
  end
  
  def destroy
    session.delete(:user_id)
    @current_user = nil
    redirect_to root_url
  end
  
  private
    def login_params
      params.require(:session).permit(:email, :password)
    end
end
