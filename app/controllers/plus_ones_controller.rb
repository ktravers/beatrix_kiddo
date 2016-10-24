class PlusOnesController < ApplicationController

  def update
    plus_one = PlusOne.find_by(id: plus_one_params[:id])
    attrs = {}

    unless plus_one
      graceful_redirect('Sorry, couldn\'t find a plus one on your rsvp.')
    end

    case plus_one_params[:response]
    when 'accepted_at'
      binding.pry
      guest = CreateUserService.new(user_params).execute

      if guest.valid?
        attrs.merge!({
          guest_id: guest.id,
          declined_at: nil,
          accepted_at: Time.now
        })

        flash[:notice] = "Thanks for confirming! We've added #{guest.full_name} to your rsvp."
      else
        set_error_redirect_vars
      end
    when 'declined_at'
      binding.pry
      attrs.merge!({
        guest_id: nil,
        accepted_at: nil,
        declined_at: Time.now
      })

      flash[:notice] = "Thanks for confirming! We have you down as no plus one."
    else
      # NOOP
    end

    plus_one.update(attrs)

    if plus_one.valid?
      redirect_path = "/events/#{rsvp.event.slug}"
    else
      set_error_redirect_vars
    end

    redirect_to redirect_path
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email)
  end

  def plus_one_params
    params.require(:plus_one).permit(:id, :response)
  end

  def set_error_redirect_vars
    flash[:error] = "Aw snap! Something blipped on our end. Please refresh your browser and try again."
    redirect_path = "/events/#{rsvp.event.slug}#plus-one"
  end
end
