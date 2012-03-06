class DashboardController < ApplicationController
  before_filter :authenticate

  def index
    @inactive_users = User.where(:student_id => nil).count

    @s = current_user.student
    @completed_votings = @s.submitted_votes.pluck(:voting_id).uniq.count
    @votings = Voting.count
  end

  def authenticate

    unless user_signed_in?
      @user = User.new
      render :template => 'devise/registrations/new'
    end
  end
end
