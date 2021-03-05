namespace :computed_data do
  desc "TODO"
  task all: :environment do
    Rake::Task["computed_data:reminders"].invoke
    Rake::Task["computed_data:lanes"].invoke
    Rake::Task["computed_data:mc_latest_dates"].invoke
    Rake::Task["computed_data:carr_tier"].invoke
    Rake::Task["computed_data:audits"].invoke
    Rake::Task["computed_data:activities_and_carr_news"].invoke
  end

  task one_time: :environment do
    time_start = Time.now
    ComputeDataService.new.all
    # ComputedDataShippersService.new.all
    time_end = Time.now
    puts "-------------------------------"
    puts "Carrier One Time Run"
    puts "Time Started: #{time_start}"
    puts "Time Ended: #{time_end}"
    puts "Computed Data Finished: (#{time_end - time_start})"
    puts "-------------------------------"
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

  task carr_news: :environment do
    time_start = Time.now
    ActiveRecord::Base.connection.execute("UPDATE carriers SET
            c_carr_new_loads_lw = (SELECT COUNT(*) FROM df_loads WHERE df_loads.ship_date >= DATE_TRUNC('WEEK', NOW()) - INTERVAL '7 DAY' and df_loads.ship_date < DATE_TRUNC('WEEK', NOW()) AND (df_loads.mc_num = carriers.mc_number AND df_loads.carrier = carriers.company_name)),
            c_carr_new_loads_2w = (SELECT COUNT(*) FROM df_loads WHERE df_loads.ship_date >= DATE_TRUNC('WEEK', NOW()) - INTERVAL '14 DAY' and df_loads.ship_date < DATE_TRUNC('WEEK', NOW()) - INTERVAL '8 DAY' AND (df_loads.mc_num = carriers.mc_number AND df_loads.carrier = carriers.company_name)),
            c_carr_new_loads_3w = (SELECT COUNT(*) FROM df_loads WHERE df_loads.ship_date >= DATE_TRUNC('WEEK', NOW()) - INTERVAL '21 DAY' and df_loads.ship_date < DATE_TRUNC('WEEK', NOW()) - INTERVAL '15 DAY' AND (df_loads.mc_num = carriers.mc_number AND df_loads.carrier = carriers.company_name)),
            c_carr_new_loads_4w = (SELECT COUNT(*) FROM df_loads WHERE df_loads.ship_date >= DATE_TRUNC('WEEK', NOW()) - INTERVAL '28 DAY' and df_loads.ship_date < DATE_TRUNC('WEEK', NOW()) - INTERVAL '22 DAY' AND (df_loads.mc_num = carriers.mc_number AND df_loads.carrier = carriers.company_name)),
            c_mc_latest_date_last_month = (SELECT COUNT(*) FROM df_loads WHERE ship_date >= DATE_TRUNC('MONTH', NOW()) - INTERVAL '1 DAY' and ship_date < DATE_TRUNC('MONTH', DATE_TRUNC('MONTH', NOW()) - INTERVAL '1 DAY') AND (df_loads.mc_num = carriers.mc_number AND df_loads.carrier = carriers.company_name))")
   time_end = Time.now
   puts "-------------------------------"
   puts "Load Count"
   puts "Time Started: #{time_start}"
   puts "Time Ended: #{time_end}"
   puts "Computed Data Finished: (#{time_end - time_start})"
   puts "-------------------------------"
  end

  task lanes: :environment do
    #Carriers
    @carrier_ids = CarrierLane.all.pluck(:carrier_id).uniq

    @carrier_ids.each do |id|
      ComputeDataService.new.lane(id)
    end

    #Shipper
    @shipper_ids = ShipperLane.all.pluck(:shipper_id).uniq

    @shipper_ids.each do |id|ActiveRecord::Base.connection.raw_connection.execute
      ComputedDataShippersService.new.lane(id)
    end
  end

  task mc_latest_dates: :environment do
    @carrier_ids = Carrier.all.pluck(:id).uniq

    @carrier_ids.each do |id|
      ComputeDataService.new.mc_latest_date(id)
    end
  end

  task carr_tier: :environment do
    ComputeDataService.new.tier
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

  task global_summaries: :environment do
    time_start = Time.now
    GlobalSummaryServices.new.run
    time_end = Time.now
    puts "-------------------------------"
    puts "Global Summary Run"
    puts "Time Started: #{time_start}"
    puts "Time Ended: #{time_end}"
    puts "Computed Data Finished: (#{time_end - time_start})"
    puts "-------------------------------"
  end

  task next_reminder_date: :environment do
    time_start = Time.now
    Reminder.where(:recurring => true).each do |reminder|
      ComputeDataService.new.next_reminder_date(reminder)
    end
    time_end = Time.now
    puts "-------------------------------"
    puts "Reminders"
    puts "Time Started: #{time_start}"
    puts "Time Ended: #{time_end}"
    puts "Computed Data Finished: (#{time_end - time_start})"
    puts "-------------------------------"
  end
end
