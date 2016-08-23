class UsersController < ApplicationController
  # before_action :login_required, only: [:edit, :reset_password]

  # get 'register'
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      login(@user)
    else
      render 'new'
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user

    if @user.update(user_params)
      flash[:notice] = 'User details updated.'
    else
      flash[:error] = "Unable to update account: #{@user.errors}"
    end

    render 'edit'
  end

  private

  def user_params
    params.permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
