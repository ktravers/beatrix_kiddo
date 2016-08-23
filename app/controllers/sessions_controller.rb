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

  def send_password
    user = User.find_by(email: params[:email])

    if user
      reset_password = generate_password
      user.password = reset_password
      user.save!

      UserMailer.deliver_reset_password(user, reset_password).deliver
      reset_session

      flash[:notice] = "Success! Your temporary password has been emailed to your account: #{user.email}"
      redirect_to login_path
    else
      flash[:notice] = 'Sorry, can\'t find an account for this email. Sign up!'
      redirect_to signup_path
    end
  end

  private

  def generate_password
    ["#{Array.new(10).map { (65 + rand(58)).chr }.join}", 'kate', 'travers', 'kc', 'boyle', '09', '03', '2017'].shuffle.join
  end
end
