class StaticPagesController < ApplicationController
  include SessionsHelper
  def home
    if current_user
      redirect_to user_path(@current_user)
    end
  end

  def settings
  end
end
