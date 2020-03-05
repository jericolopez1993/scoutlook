namespace :computed_data do
  desc "TODO"
  task all: :environment do
    Rake::Task["computed_data:reminders"].invoke
    Rake::Task["computed_data:lanes"].invoke
    Rake::Task["computed_data:mc_latest_dates"].invoke
    Rake::Task["computed_data:audits"].invoke
    Rake::Task["computed_data:activities_and_carr_news"].invoke
  end

  task one_time: :environment do
    ComputeDataService.new.all
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


  task activities_and_carr_news: :environment do
    #Carriers
    @carrier_ids = Carrier.all.pluck(:id).uniq

    @carrier_ids.each do |id|
      ComputeDataService.new.activity(id)
      ComputeDataService.new.carr_new(id)
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
