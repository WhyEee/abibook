class DashboardController < ApplicationController
  before_filter :authenticate

  def index
    @inactive_users = User.where(:student_id => nil).count
  end

  def authenticate

    unless user_signed_in?
      @user = User.new
      render :template => 'devise/registrations/new'
    end
  end
end
