class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # before_action login_required

  def login(user)
    session[:user_id] = user.id
  end

  def current_user
    return unless session[:user_id]
    @current_user ||= User.find(session[:user_id])
  end
  helper_method :current_user

  def logged_in?
    !!current_user
  end
  helper_method :logged_in?

  # TODO: enforce client-side?
  def login_required
    unless logged_in?
      flash[:notice] = 'Please login to view this page.'
      redirect_to login_path
    end
  end
end
