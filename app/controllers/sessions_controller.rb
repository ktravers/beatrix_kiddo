class SessionsController < ApplicationController

  def create
    user = User.fuzzy_match(user_params[:email])

    if user
      login(user)
      redirect_path = session[:redirect_path]
      session.delete(:redirect_path)

      redirect_to redirect_path
    else
      flash.alert = 'Sorry, can\'t find an invite for that email address. Try again?'
      redirect_to "#{login_path}#login"
    end
  end

  def destroy
    reset_session
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:email)
  end

end
