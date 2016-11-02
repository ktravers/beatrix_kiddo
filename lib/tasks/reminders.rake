namespace :reminders do
  desc 'send out event reminders to unconfirmed guests'
  task :remind_unconfirmed => :environment do
    event_id = nil
    puts "\nInput event id:"

    loop do
      event_id = STDIN.gets.chomp
      break if event_id.length == 1
      puts 'Please enter one event id.'
    end

    rsvps = Rsvp.unconfirmed.where(event_id: event_id)
    send_reminders(rsvps)
  end

  desc 'send out event reminders to attending guests'
  task :remind_attending => :environment do
    event_id = nil
    puts "\nInput event id:"

    loop do
      event_id = STDIN.gets.chomp
      break if event_id.length == 1
      puts 'Please enter one event id.'
    end

    rsvps = Rsvp.attending.where(event_id: event_id)
    send_reminders(rsvps)
  end

  def send_reminders(rsvps)
    mail_count = 0
    fail_count = 0

    rsvps.each do |rsvp|
      begin
        guest_email = rsvp.user.email
        puts "Sending reminder email to #{guest_email}..."

        RsvpMailer.send_reminder(rsvp).deliver_now

        mail_count += 1
      rescue
        fail_count += 1
        puts "Failed to send reminder email to ##{guest_email}\n"
      end
    end

    puts "\nSuccessfully emailed #{mail_count} guests."
    puts "#{fail_count} failures."
  end
end
