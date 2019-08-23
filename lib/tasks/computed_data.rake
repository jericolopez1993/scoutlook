namespace :computed_data do
  desc "TODO"
  task reminders: :environment do
    @carrier_ids = Reminder.all.pluck(:carrier_id).uniq

    @carrier_ids.each do |id|
      ComputeDataService.new.reminder(id)
    end
  end

  task lanes: :environment do
    @carrier_ids = CarrierLane.all.pluck(:carrier_id).uniq

    @carrier_ids.each do |id|
      ComputeDataService.new.lane(id)
    end
  end

  task mc_latest_dates: :environment do
    @carrier_ids = Carrier.all.pluck(:id).uniq

    @carrier_ids.each do |id|
      ComputeDataService.new.mc_latest_date(id)
    end
  end

  task audits: :environment do
    @carrier_ids = Carrier.all.pluck(:id).uniq

    @carrier_ids.each do |id|
      ComputeDataService.new.audit(id)
    end
  end
end
