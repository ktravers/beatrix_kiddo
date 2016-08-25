class SessionsController < ApplicationController

  def create
    user = User.find_by(email: user_params[:email])#.try(:authenticate, params[:password])

    if user
      login(user)
      redirect_to "/events/#{user_params[:event_slug]}"
    else
      flash[:notice] = 'Sorry, can\'t find an invite for that email address. Try again?'
      redirect_to "/events/#{user_params[:event_slug]}#login"
    end
  end

  def destroy
    reset_session
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :event_slug)
  end

end
