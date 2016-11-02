class PlusOnesController < ApplicationController

  def update
    plus_one = PlusOne.find_by(id: plus_one_params[:id])

    unless plus_one
      graceful_redirect("Sorry, couldn't find a plus one on your rsvp.") and return
    end

    confirmation = plus_one_params[:response]

    unless confirmation
      redirect_for_retry(plus_one, 'Please check yes or no.') and return
    end

    response = PlusOneManager.new(
      plus_one_id: plus_one.id,
      user_params: user_params,
      confirmation: confirmation
    ).execute

    if response.success
      flash[:notice] = response.message
      redirect_to "/events/#{plus_one.event_slug}"
    else
      redirect_for_retry(plus_one)
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email)
  end

  def plus_one_params
    params.require(:plus_one).permit(:id, :response)
  end

  def redirect_for_retry(plus_one, message=nil)
    flash[:error] = message || default_error_message
    return redirect_to "/events/#{plus_one.event_slug}#plus-one"
  end

  def default_error_message
    "Aw snap! Something blipped on our end. Please refresh your browser and try again."
  end
end
