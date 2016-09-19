namespace :invite do
  desc 'send invite for specific guest + event'
  task :manual => :environment do
  end

  desc 'send out all Save the Date invites'
  task :save_the_date => :environment do
    rsvps = Rsvp.where(event_id: 1).limit(4)

    rsvps.each do |rsvp|
      UserMailer.send_save_the_date(rsvp).deliver_now
    end
  end
end
