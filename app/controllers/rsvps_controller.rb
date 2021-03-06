class RsvpsController < ApplicationController

  def update
    rsvp = Rsvp.find_by(id: rsvp_params[:id])
    attrs = {}

    case rsvp_params[:response]
    when 'accepted_at'
      attrs.merge!({
        declined_at: nil,
        accepted_at: Time.now,
        sent_at: rsvp.sent_at || Time.now
      })
    when 'declined_at'
      attrs.merge!({
        accepted_at: nil,
        declined_at: Time.now,
        sent_at: rsvp.sent_at || Time.now
      })
    else
      redirect_for_retry(rsvp, 'Please check yes or no.') and return
    end

    rsvp.update(attrs)
    redirect_for_retry(rsvp) and return unless rsvp.valid?

    if rsvp.attending? && rsvp.unconfirmed_plus_one?
      redirect_path = "/events/#{rsvp.event.slug}#plus-one"
    else
      flash[:notice] = "Thanks for rsvping! Check your inbox for a confirmation email."
      redirect_path = "/events/#{rsvp.event.slug}"
    end

    sync_plus_one!(rsvp)
    RsvpMailer.send_confirmation(rsvp).deliver_now

    redirect_to redirect_path
  end

  private

  def rsvp_params
    params.require(:rsvp).permit(:id, :response)
  end

  def redirect_for_retry(rsvp, message=nil)
    flash[:error] = message || default_error_message
    return redirect_to "/events/#{rsvp.event.slug}#rsvp"
  end

  def default_error_message
    "Aw snap! Something blipped on our end. Please refresh your browser and try again."
  end

  def sync_plus_one!(rsvp)
    plus_one = PlusOne.find_by(rsvp_id: rsvp.id, user_id: rsvp.user_id)
    return unless plus_one && rsvp.not_attending?

    PlusOneManager.new(
      plus_one_id: plus_one.id,
      confirmation: 'declined_at'
    ).execute
  end
end
