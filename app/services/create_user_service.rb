class CreateUserService
  attr_reader :first_name, :last_name, :email

  def initialize(payload)
    first_name = payload[:first_name]
    last_name  = payload[:last_name]
    email      = payload[:email]

    @first_name = first_name.strip.titleize unless first_name.blank?
    @last_name  = last_name.strip.titleize unless last_name.blank?
    @email      = email.strip.downcase unless email.blank?
  end

  def execute
    User.find_or_create_by(
      first_name: first_name,
      last_name: last_name,
      email: email
    )
  end
end
