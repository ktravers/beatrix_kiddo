class SessionsController < ApplicationController

  def create
    user = User.find_by(email: params[:email]).try(:authenticate, params[:password])

    if user
      login(user)
      redirect_to root_path
    else
      flash.now[:notice] = 'User name or password is not valid.'
      render 'new'
    end
  end

  def destroy
    reset_session
    redirect_to root_path
  end

  def reset_password
  end

  def send_password
    user = User.find_by(email: params[:email])

    if user
      random_password = ["#{Array.new(10).map { (65 + rand(58)).chr }.join}", 'kate', 'travers', 'kc', 'boyle', '09', '03', '2017'].shuffle.join
      user.password = random_password
      user.save!

      UserMailer.create_and_deliver_password_change(user, random_password).deliver
      reset_session

      flash[:notice] = "Success! Your temporary password has been emailed to your account: #{user.email}"
      redirect_to login_path
    else
      flash[:notice] = 'Sorry, we can\'t find your account. Sign up!'
      redirect_to signup_path
    end
  end
end
