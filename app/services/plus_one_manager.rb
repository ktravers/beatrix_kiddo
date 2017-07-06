class PlusOneManager
  attr_reader :plus_one, :guest, :success, :message

  BIG_DAY_EVENT_IDS = [6,7,8]

  def initialize(payload)
    @plus_one = PlusOne.find_by(id: payload[:plus_one_id])
    @user_params = payload[:user_params]
    @confirmation = payload[:confirmation]
  end

  def execute
    begin
      if @user_params
        sanitize_user_params!
        set_guest!
      end

      update_plus_one!
      unify_big_day_events!
      set_message!
      success!

      self
    rescue => e
      failure!(e.message)
      self
    end
  end

  private

  def sanitize_user_params!
    first_name = @user_params[:first_name].try(:strip).try(:titleize)
    last_name  = @user_params[:last_name].try(:strip).try(:titleize)
    email      = @user_params[:email].try(:strip).try(:downcase)

    @user_params = {
      first_name: first_name,
      last_name: last_name,
      email: email
    }
  end

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

  def update_plus_one!
    case @confirmation
    when 'accepted_at'
      raise 'Must provide user params' unless guest

      attrs = {
        guest_id: guest.id,
        declined_at: nil,
        accepted_at: Time.now
      }
    when 'declined_at'
      attrs = {
        guest_id: nil,
        accepted_at: nil,
        declined_at: Time.now
      }
    end

    plus_one.update!(attrs)
  end

  def unify_big_day_events!
    return unless BIG_DAY_EVENT_IDS.include?(plus_one.id)

    PlusOne.where(id: BIG_DAY_EVENT_IDS).map do |po|
      po.update(guest: @guest)
    end
  end

  def set_message!
    @message = case @confirmation
    when 'accepted_at'
      "Thanks for confirming! #{guest.full_name} is your plus one."
    when 'declined_at'
      "Thanks for confirming! We have you down as no plus one."
    end
  end

  def success!
    @success = true
  end

  def failure!(msg)
    Rails.logger.error(msg)
    @message, @success = msg, false
  end
end
