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

  desc 'create plus one(s)'
  task :create_plus_ones => :environment do
    # user_ids = [4,11,21,29,36,37,43,44,60,63,64,65,71,73,76,78,79,84,85,88,90,94,95,101,102,103,104,105,106,107,108,109,110,111,112,113,114,117,118,119,120,123,125,126,128,130,131,134,137,139,145]

    user_ids = []
    puts "\nInput one or more user ids, separated by commas: "

    loop do
      user_ids = STDIN.gets.chomp.split(',')
      break if user_ids.length >= 1
      puts 'Please enter at least one user id.'
    end

    success_count = 0
    fail_count = 0

    begin
      user_ids.each do |user_id|
        user = User.find(user_id)
        puts "Starting process for user##{user_id}: #{user.full_name}..."

        puts "Retrieving rsvps..."
        engagement_party_rsvp_id = Rsvp.find_by(user_id: user_id, event_id: 2).try(:id)
        ceremony_rsvp_id = Rsvp.find_by(user_id: user_id, event_id: 6).try(:id)
        reception_rsvp_id = Rsvp.find_by(user_id: user_id, event_id: 7).try(:id)
        after_party_rsvp_id = Rsvp.find_by(user_id: user_id, event_id: 8).try(:id)

        puts "Creating plus ones..."
        PlusOne.find_or_create_by(user_id: user_id, rsvp_id: engagement_party_rsvp_id)
        PlusOne.find_or_create_by(user_id: user_id, rsvp_id: ceremony_rsvp_id)
        PlusOne.find_or_create_by(user_id: user_id, rsvp_id: reception_rsvp_id)
        PlusOne.find_or_create_by(user_id: user_id, rsvp_id: after_party_rsvp_id)

        plus_ones = PlusOne.where(user_id: user_id)
        puts "Success! #{plus_ones.count} plus ones total for #{user.full_name}: rsvps##{plus_ones.pluck(:rsvp_id).join(', ')}\n\n"
        success_count += 1
      end
    rescue
      fail_count += 1
      puts "Failed to create plus ones for user##{user_id}: #{user.full_name}\n\n"
    end

    puts "\nSuccessfully created plus ones for #{success_count} users."
    puts "#{fail_count} failures."
  end
end
