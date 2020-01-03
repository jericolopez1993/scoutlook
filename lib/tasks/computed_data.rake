namespace :computed_data do
  desc "TODO"
  task all: :environment do
    Rake::Task["computed_data:reminders"].invoke
    Rake::Task["computed_data:lanes"].invoke
    Rake::Task["computed_data:mc_latest_dates"].invoke
    Rake::Task["computed_data:audits"].invoke
  end

  task reminders: :environment do
    #Carriers
    @carrier_ids = Carrier.all.pluck(:id).uniq

    @carrier_ids.each do |id|
      ComputeDataService.new.reminder(id)
    end

    #Shipper
    @shipper_ids = Shipper.all.pluck(:id).uniq

    @shipper_ids.each do |id|
      ComputedDataShippersService.new.reminder(id)
    end
  end

  task lanes: :environment do
    #Carriers
    @carrier_ids = CarrierLane.all.pluck(:carrier_id).uniq

    @carrier_ids.each do |id|
      ComputeDataService.new.lane(id)
    end

    #Shipper
    @shipper_ids = ShipperLane.all.pluck(:shipper_id).uniq

    @shipper_ids.each do |id|
      ComputedDataShippersService.new.lane(id)
    end
  end

  task mc_latest_dates: :environment do
    @carrier_ids = Carrier.all.pluck(:id).uniq

    @carrier_ids.each do |id|
      ComputeDataService.new.mc_latest_date(id)
    end
  end

  task audits: :environment do
    #Carriers
    @carrier_ids = Carrier.all.pluck(:id).uniq

    @carrier_ids.each do |id|
      ComputeDataService.new.audit(id)
    end

    #Shipper
    @shipper_ids = Shipper.all.pluck(:id).uniq

    @shipper_ids.each do |id|
      ComputedDataShippersService.new.audit(id)
    end
  end
end
