class PlusOneManager
  attr_reader :plus_one, :guest, :success, :message

  def initialize(payload)
    @plus_one = payload[:plus_one]
    @confirmation = payload[:confirmation]

    first_name = payload[:user_params][:first_name].try(:strip).try(:titleize)
    last_name  = payload[:user_params][:last_name].try(:strip).try(:titleize)
    email      = payload[:user_params][:email].try(:strip).try(:downcase)

    @user_params = {
      first_name: first_name,
      last_name: last_name,
      email: email
    }
  end

  def execute
    begin
      set_guest!
      attrs = {}

      case @confirmation
      when 'accepted_at'
        # set_rsvps!
        message = "Thanks for confirming! We've added #{guest.full_name} to your rsvp."

        attrs.merge!({
          guest_id: guest.id,
          declined_at: nil,
          accepted_at: Time.now
        })
      when 'declined_at'
        # unset_rsvps!
        message = 'Thanks for confirming! We have you down as no plus one.'

        attrs.merge!({
          guest_id: nil,
          accepted_at: nil,
          declined_at: Time.now
        })
      end

      plus_one.update!(attrs)

      success!(message)
    rescue => e
      failure!(e.message)
    end
  end

  private

  def set_guest!
    @guest = plus_one.guest_id ? update_guest! : set_new_guest!
  end

  def update_guest!
    plus_one.guest.update!(@user_params)
    plus_one.guest
  end

  def set_new_guest!
    User.find_or_create_by!(@user_params)
  end

  # def set_rsvps!
  #   event_ids = Rsvp.where(user_id: plus_one.user_id).pluck(:event_id)

  #   event_ids.each do |event_id|
  #     Rsvp.find_or_create_by!(
  #       user_id: guest.id,
  #       event_id: event_id,
  #       sent_at: Time.now,
  #       accepted_at: Time.now
  #     )
  #   end
  # end

  # def unset_rsvps!
  #   Rsvp.where(user_id: guest.id).each do |rsvp|
  #     File.new('/log/rsvp_log.txt', 'a') do |f|
  #       f.write(
  #         <<~STR
  #           Rsvp destroyed:
  #             UserId: #{rsvp.user_id}
  #             EventId: #{rsvp.event_id}
  #             AcceptedAt: #{rsvp.accepted_at}
  #             DeclinedAt: #{rsvp.declined_at}
  #             DestroyedAt: #{Time.now}

  #         STR
  #       )
  #     end

  #     rsvp.destroy!
  #   end
  # end

  def success!(msg)
    @message, @success = msg, true
  end

  def failure!(msg)
    Rails.logger.error(msg)
    @message, @success = msg, false
  end
end
