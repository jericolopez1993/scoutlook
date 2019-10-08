namespace :add_new_carriers do
  desc "Add the New Carriers to Carrier Table."
  task check_and_create: :environment do
    AddNewCarrierToCarrierService.new.check_and_create
  end
end
