class StaticPagesController < ApplicationController
  include ApplicationHelper
  def home
    if logged_in?
      redirect_to user_path(@current_user)
    end
  end
end
