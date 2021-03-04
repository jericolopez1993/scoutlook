namespace :checks_new_carriers do
  desc "Checks New Carrier if already interviewed."
  task check_and_drop: :environment do
    ChecksCarrNewTableServices.new.check_and_create
  end

  task check_and_move: :environment do
    time_start = Time.now
    ChecksCarrNewTableServices.new.check_and_move
    time_end = Time.now
    puts "-------------------------------"
    puts "Check and Move New Carriers to Scoutlook Carrier"
    puts "Time Started: #{time_start}"
    puts "Time Ended: #{time_end}"
    puts "Computed Data Finished: (#{time_end - time_start})"
    puts "-------------------------------"
  end
end
