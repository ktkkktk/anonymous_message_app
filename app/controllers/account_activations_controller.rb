class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(params[:id])
      user.activate
      log_in user
      flash[:success] = "アカウントが登録されました！"
      redirect_to user
    else
      flash[:denger] = "無効なactivationリンクです"
      redirect_to root_url
    end
  end
  
end
