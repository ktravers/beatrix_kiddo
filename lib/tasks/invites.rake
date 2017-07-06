namespace :invites do
  desc 'send invite(s) for specific guest(s) + event'
  task :specific_event_guests => :environment do
    rsvp_ids = []
    puts "\nInput one or more rsvp ids, separated by commas: "

    loop do
      rsvp_ids = STDIN.gets.chomp.split(',')
      break if rsvp_ids.length >= 1
      puts 'Please enter at least one rsvp id.'
    end

    rsvps = Rsvp.unsent.where(id: rsvp_ids)
    send_rsvps(rsvps)
  end

  desc 'send out all invites for specific event'
  task :all_event_guests => :environment do
    event_id = nil
    puts "\nInput event id:"

    loop do
      event_id = STDIN.gets.chomp
      break if event_id.length == 1
      puts 'Please enter one rsvp id.'
    end

    rsvps = Rsvp.unsent.where(event_id: event_id)

    if rsvps.length > 0
      send_rsvps(rsvps)
    else
      puts "All invites have already been sent for event ##{event_id}"
    end
  end

  def send_rsvps(rsvps)
    mail_count = 0
    fail_count = 0

    rsvps.each do |rsvp|
      begin
        guest_email = rsvp.user.email
        puts "Sending email to #{guest_email}..."

        case rsvp.event_id
        when 1
          UserMailer.send_save_the_date(rsvp).deliver_now
        when 6
          UserMailer.send_official_invitation(rsvp).deliver_now
        else
          UserMailer.send_invite(rsvp).deliver_now
        end

        mail_count += 1
      rescue
        fail_count += 1
        puts "Failed to send email to ##{guest_email}\n"
      end
    end

    puts "\nSuccessfully emailed #{mail_count} guests."
    puts "#{fail_count} failures."
  end
end
