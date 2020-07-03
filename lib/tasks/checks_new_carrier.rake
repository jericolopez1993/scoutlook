namespace :checks_new_carriers do
  desc "Checks New Carrier if already interviewed."
  task check_and_drop: :environment do
    ChecksCarrNewTableServices.new.check_and_create
  end

  task check_and_move: :environment do
    ChecksCarrNewTableServices.new.check_and_move
  end
end
