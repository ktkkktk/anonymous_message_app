class SettingsController < ApplicationController
  include ApplicationHelper
  before_action :require_login, only: :show
  
  def show
    
  end
end
