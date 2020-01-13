class MergeDataServices
  def carrier(main_carrier_id, merge_carrier_ids)
    if main_carrier_id && merge_carrier_ids
      carrier = Carrier.find(main_carrier_id)
      carriers = Carrier.where("carriers.id IN (#{merge_carrier_ids})")

      carrier_contacts = CarrierContact.where("carrier_id IN (#{merge_carrier_ids})")
      carrier_locations = CarrierLocation.where("carrier_id IN (#{merge_carrier_ids})")
      carrier_companies = CarrierCompany.where("carrier_id IN (#{merge_carrier_ids})")
      carrier_lanes = CarrierLane.where("carrier_id IN (#{merge_carrier_ids})")
      reminders = Reminder.where("reminders.carrier_id IN (#{merge_carrier_ids})")
      activities = Activity.where("activities.carrier_id IN (#{merge_carrier_ids})")
      rates = Rate.where("rates.carrier_id IN (#{merge_carrier_ids})")
      carrier_notes = CarrierNote.where("carrier_id IN (#{merge_carrier_ids})")
      loads = DfLoad.where("mc_num IN (#{carriers.pluck(:mc_number).map { |n| "'#{n}'" }.join(",")})")
      load_tiles = LoadTile.where("carrier_id IN (#{merge_carrier_ids})")
      mc_latest_dates = McLatestDate.where("mcnum IN (#{carriers.pluck(:mc_number).map { |n| "'#{n}'" }.join(",")})")

      #Move all the relationships to the main carrier.
      carrier_contacts.update_all(:carrier_id => main_carrier_id)
      carrier_locations.update_all(:carrier_id => main_carrier_id)
      carrier_companies.update_all(:carrier_id => main_carrier_id)
      carrier_lanes.update_all(:carrier_id => main_carrier_id)
      reminders.update_all(:carrier_id => main_carrier_id)
      activities.update_all(:carrier_id => main_carrier_id)
      rates.update_all(:carrier_id => main_carrier_id)
      carrier_notes.update_all(:carrier_id => main_carrier_id)
      loads.update_all(:mc_num => carrier.mc_number)
      load_tiles.update_all(:carrier_id => main_carrier_id)
      mc_latest_dates.update_all(:mcnum => carrier.mc_number)

      #Sum up all the numbers from the merged carrier to the main carrier.
      carrier.power_units = (carrier.power_units ? carrier.power_units : 0) + carriers.sum(:power_units)
      carrier.reefers = (carrier.reefers ? carrier.reefers : 0) + carriers.sum(:reefers)
      carrier.teams = (carrier.teams ? carrier.teams : 0) + carriers.sum(:teams)
      carrier.c_mc_latest_date_load_days = (carrier.c_mc_latest_date_load_days ? carrier.c_mc_latest_date_load_days : 0) + carriers.sum(:c_mc_latest_date_load_days)
      carrier.c_mc_latest_date_last_month = (carrier.c_mc_latest_date_last_month ? carrier.c_mc_latest_date_last_month : 0) + carriers.sum(:c_mc_latest_date_last_month)
      carrier.c_mc_latest_date_last_6_months = (carrier.c_mc_latest_date_last_6_months ? carrier.c_mc_latest_date_last_6_months : 0) + carriers.sum(:c_mc_latest_date_last_6_months)
      carrier.owner_operators = (carrier.owner_operators ? carrier.owner_operators : 0) + carriers.sum(:owner_operators)
      carrier.dry_vans = (carrier.dry_vans ? carrier.dry_vans : 0) + carriers.sum(:dry_vans)
      carrier.flat_beds = (carrier.flat_beds ? carrier.flat_beds : 0) + carriers.sum(:flat_beds)
      carrier.teams = (carrier.teams ? carrier.teams : 0) + carriers.sum(:teams)
      carrier.save

      #Delete all the merged carrier.
      carriers.delete_all

      #Update also all the computed data.
      ComputeDataService.new.reminder(main_carrier_id)
      ComputeDataService.new.lane(main_carrier_id)
      ComputeDataService.new.mc_latest_date(main_carrier_id)
      ComputeDataService.new.audit(main_carrier_id)
    end
  end
end
