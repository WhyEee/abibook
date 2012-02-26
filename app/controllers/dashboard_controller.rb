class DashboardController < ApplicationController
  before_filter :authenticate

  def index
  end

  def authenticate

    unless user_signed_in?
      @user = User.new
      render :template => 'devise/registrations/new'
    end
  end
end
