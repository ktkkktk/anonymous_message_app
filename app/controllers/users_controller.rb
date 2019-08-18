class UsersController < ApplicationController
  include ApplicationHelper
  require 'mini_magick'
  require 'securerandom'
  
  def create
    if User.find_by(email: params[:user][:email])
      flash[:warning] = "そのメールアドレスはすでに登録されています。"
    else
      @user = User.new(user_params)
      if @user.save
        @user.send_activation_email
        message = "確認メールを入力したメールアドレスに送りました。"
        message += "リンクをクリックしてアカウントを有効化してください。"
        flash[:info] = message
      end
    end
    redirect_to root_url
  end
  
  def show
    if logged_in?
      @message_cards = current_user.message_cards.paginate(page: params[:page], per_page: 6)
    end
  end
  
  def settings

  end
  
  private
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end

end
