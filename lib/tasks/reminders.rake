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

    rsvps = Rsvp.sent.unconfirmed.where(event_id: event_id)
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

  desc 'send out travel reminders by email'
  task :send_by_email => :environment do
    emails = []
    puts "\nInput comma separated list of emails:"

    loop do
      emails = STDIN.gets.chomp.split(',').map(&:strip)
      break if emails.length >= 1
      puts 'Please enter at least one email.'
    end

    send_travel_reminders(emails)
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

  def send_travel_reminders(emails)
    mail_count = 0
    fail_count = 0

    emails.each do |email|
      begin
        puts "Emailing travel reminder to #{email}..."

        UserMailer.send_travel_reminder(email).deliver_now

        mail_count += 1
      rescue
        fail_count += 1
        puts "Failed to email travel reminder to ##{email}\n"
      end
    end

    puts "\nSuccessfully emailed #{mail_count} guests."
    puts "#{fail_count} failures."
  end
end
