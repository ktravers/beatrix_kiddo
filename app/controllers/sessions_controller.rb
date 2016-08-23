class SessionsController < ApplicationController

  def create
    user = User.find_by(email: params[:email]).try(:authenticate, params[:password])

    if user
      login(user)
      redirect_to root_path
    else
      flash.now[:notice] = 'Either your email or password isn\'t valid. Try again?'
      render 'new'
    end
  end

  def destroy
    reset_session
    redirect_to root_path
  end

end
