class UsersController < ApplicationController
  before_filter :authenticate_user!, except: [:approved]

  def index
    authorize! :index, @user, :message => 'Not authorized as an administrator.'
    
    @users = User.paginate(page: params[:page], per_page: 10)
  end

  def show
    @user = User.find(params[:id])
  end
  
  def update
    authorize! :update, @user, :message => 'Not authorized as an administrator.'
    @user = User.find(params[:id])
    role = Role.find(params[:user][:role_ids]) unless params[:user][:role_ids].nil?
    params[:user] = params[:user].except(:role_ids)
    
    check_status

    if @user.update_attributes(params[:user])
      process_status

      @user.update_plan(role) unless role.nil?
      redirect_to users_path, :notice => "User updated."
    else
      redirect_to users_path, :alert => "Unable to update user."
    end
  end

  def approve
    authorize! :update, @user, :message => 'Not authorized as an administrator.'
    @user = User.find_by_email(params[:email])
    @user.status = "Approved"
    @user.save
    UserMailer.approve_user(@user).deliver

    redirect_to users_path, notice: "You approved #{@user.name}'s application"
  end

  def approved
    @user = User.find(params[:id])
  end

  def decline
    authorize! :update, @user, :message => 'Not authorized as an administrator.'
    @user = User.find_by_email(params[:email])
    @user.status = "Declined"
    @user.save
    UserMailer.decline_user(@user).deliver

    redirect_to users_path, notice: "You declined #{@user.name}'s application"
  end

  def destroy
    authorize! :destroy, @user, :message => 'Not authorized as an administrator.'
    user = User.find(params[:id])
    unless user == current_user
      user.destroy
      redirect_to users_path, :notice => "User deleted."
    else
      redirect_to users_path, :notice => "Can't delete yourself."
    end
  end

  def check_status
    @status_changed = true if @user.status != params[:user][:status]
  end

  def process_status
    return if @status_changed == false
    if @user.status == "Approved"
      UserMailer.approve_user(@user).deliver
    elsif @user.status == "Declined"
      UserMailer.decline_user(@user).deliver
    end
  end
end