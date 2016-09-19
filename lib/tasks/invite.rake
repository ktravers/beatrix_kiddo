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
    rsvps.each { |rsvp| send_email(rsvp) }
  end

  desc 'send out all Save the Date invites'
  task :save_the_date => :environment do
    rsvps = Rsvp.where(event_id: 1)
    rsvps.each { |rsvp| send_email(rsvp) }
  end

  def send_email(rsvp)
    UserMailer.send_save_the_date(rsvp).deliver_now
  end
end
