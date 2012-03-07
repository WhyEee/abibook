class Admin::ActivationController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authenticate_staff
  def index
    @users = User.where(:student_id => nil)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(params[:user])
      UserMailer.activation_email(@user).deliver
      redirect_to activations_path, notice: "<b>Super!</b> #{@user.student.full_name} wurde freigeschaltet!"
    else
      render action: "edit"
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to activations_path
  end

  def authenticate_staff
    if current_user.user?
      redirect_to root_path, notice: '<b>Halt, stopp!</b> Du darfst keine Benutzer freischalten!'
    end
  end
end
