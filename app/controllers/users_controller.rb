class UsersController < ApplicationController
  before_action :login_required, only: [:update]
  # before_filter :resetting?, only: [:edit]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login(@user)
      if session[:dinner_path]
        redirect_to session[:dinner_path]
      # elsif session[:reset_path]
      #   redirect_to session[:reset_path]
      else
        redirect_to user_path(@user)
      end
    else
      render 'new'
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user

    if !!@user.authenticate(params[:password])
      @user.name  = params[:name]
      @user.email = params[:email]

      if !params[:new_password].empty?
        @user.password = params[:new_password]
        @user.password_confirmation = params[:confirm_password]

        if @user.save
          flash[:notice] = 'Details updated.'
        else
          flash[:error] = 'Please confirm new password.'
        end
      else
        @user.save
        flash[:notice] = 'User details updated.'
      end
    else
      flash[:notice] = 'Invalid email/password combination. Click below to reset your password.'
    end

    render 'edit'
  end

  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
