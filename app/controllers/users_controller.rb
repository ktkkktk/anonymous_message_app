class UsersController < ApplicationController
  include ApplicationHelper
  
  def create
    
  end
  
  def show
    if logged_in?
      @message_cards = current_user.message_cards.paginate(page: params[:page], per_page: 6)
    end
  end
  
  def settings

  end
end