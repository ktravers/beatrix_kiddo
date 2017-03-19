namespace :announcements do
  desc 'send out announcements to all invitees'
  task :send_by_email => :environment do
    emails = []
    puts "\nInput comma separated list of emails:"

    loop do
      emails = STDIN.gets.chomp.split(',').map(&:strip)
      break if emails.length >= 1
      puts 'Please enter at least one email.'
    end

    send_announcements(emails)
  end

  def send_announcements(emails)
    mail_count = 0
    fail_count = 0

    emails.each do |email|
      begin
        puts "Emailing announcement to #{email}..."

        UserMailer.send_announcement(email).deliver_now

        mail_count += 1
      rescue
        fail_count += 1
        puts "Failed to email announcement to ##{email}\n"
      end
    end

    puts "\nSuccessfully emailed #{mail_count} guests."
    puts "#{fail_count} failures."
  end
end
