require 'csv'

namespace :users do
  desc 'add users from csv file'
  task :update_guest_list => :environment do
    # Include CSV file 'invites.csv' at root level of project directory
    # CSV columns should be organized as follows with events in order left to right from first to last:
    #
    # First name | Last name | Email             | Save The Date | Engagement Party | etc...
    # ---------------------------------------------------------------------------------------
    # Beatrix    | Kiddo     | bride@thebride.co | yes           | yes              | yes

    CSV.foreach('invites.csv', headers: true) do |row|
      # row => ['Beatrix', 'Kiddo', 'bride@thebride.co', 'yes', 'yes' etc...]

      first_name = row[0].strip.capitalize unless row[0].blank?
      last_name  = row[1].strip.capitalize unless row[1].blank?
      email      = row[2].strip.downcase unless row[2].blank?
      full_name  = "#{first_name} #{last_name}"

      puts "Finding or creating account for #{full_name}...\n"
      user = User.find_or_create_by(
        first_name: first_name,
        last_name: last_name,
        email: email
      )

      if user.valid?
        puts "Confirmed account: id##{user.id}\n"
      else
        puts "Error finding/creating account for #{full_name}\n"
      end

      affirmative_responses = ['yes', 'y', 'true', 't', '1']
      rsvp_count = 0

      puts "Finding or creating rsvps for #{full_name}..."
      row[3..-1].each.with_index(1) do |cell, index|
        if cell && affirmative_responses.include?(cell.downcase)
          rsvp = Rsvp.find_or_create_by(
            user_id: user.id,
            event_id: index
          )

          if rsvp.valid?
            rsvp_count += 1
          end
        end
      end

      puts "Confirmed: #{rsvp_count} rsvps for #{full_name}.\n\n"
    end

    puts "Total users: #{User.count}\n"
    puts "Total events: #{Event.count}\n"
    puts "Total rsvps: #{Rsvp.count}\n"
  end
end
