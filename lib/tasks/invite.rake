namespace :invite do
  desc 'send invite for specific guest + event'
  task :manual => :environment do
    rsvp_ids = []
    puts "\nInput one or more rsvp ids, separated by commas: "

    loop do
      rsvp_ids = STDIN.gets.chomp.split(',')
      break if rsvp_ids.length >= 1
      puts 'Please enter at least one rsvp id.'
    end

    rsvps = Rsvp.where(id: rsvp_ids)
    send_rsvps(rsvps)
  end

  desc 'send out all Save the Date invites'
  task :save_the_date => :environment do
    rsvps = Rsvp.where(event_id: 1)
    send_rsvps(rsvps)
  end

  def send_rsvps(rsvps)
    mail_count = 0
    fail_count = 0

    rsvps.each do |rsvp|
      begin
        guest_email = rsvp.user.email
        puts "Sending email to #{guest_email}..."
        UserMailer.send_save_the_date(rsvp).deliver_now

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
