class ComputeDataService
  def all
    # begin
      Carrier.all.each do |carrier|
        begin
          if carrier
            c_reminder_date = nil
            c_reminder_interval = nil
            c_reminder_id = nil
            c_reminder_notes = nil
            c_reminder_type = nil
            c_lane_origin = nil
            c_lane_destination = nil
            c_lane_id = nil
            c_activity_date_opened = nil
            c_activity_campaign_name = nil
            c_activity_activity_type = nil
            c_activity_status = nil
            c_carr_new_loads_lw = nil
            c_carr_new_loads_2w = nil
            c_carr_new_loads_3w = nil
            c_carr_new_loads_4w = nil
            c_mc_latest_date_tier = nil
            c_mc_latest_date_last_month = nil
            c_mc_latest_date_last_6_months = nil
            c_mc_latest_date_load_days = nil
            c_auditable_last_activity_date = nil

            # Reminders - START
            carrier.reminders.order('updated_at DESC').each do |reminder|
              c_reminder_date = Reminder.compute_next_reminder_date(reminder)

              if c_reminder_date
                c_reminder_interval = reminder.reminder_interval
                c_reminder_id = reminder.id
                c_reminder_notes = reminder.notes
                c_reminder_type = reminder.reminder_type
                break
              end
            end
            # Reminders - END

            # Activities - START
            activity = Activity.where(:carrier_id => carrier.id).order("created_at DESC").first
            if activity
              c_activity_date_opened = activity.date_opened
              c_activity_campaign_name = activity.campaign_name
              c_activity_activity_type = activity.activity_type
              c_activity_status = activity.status
            end
            # Activities - END

            # Lanes - START
            lane = CarrierLane.where(:carrier_id => carrier.id).order("created_at DESC").first
            if lane
              c_lane_origin = lane.lane_origin
              c_lane_destination = lane.lane_destination
              c_lane_id = lane.id
            end
            # Lanes - END

            # Audit - START
            log = Log.where("model_type IN ('Carrier', 'CarrierCompany', 'CarrierContact', 'CarrierLane', 'CarrierLocation', 'CarrierNote', 'Activity', 'Rate', 'Reminder')").where(:main_id => carrier.id).order("created_at DESC").first

            if log
              c_auditable_last_activity_date = log.created_at
            end
            # Audit - END

            # Update Carrier
            carrier.update_attributes(
              :c_reminder_id => c_reminder_id,
              :c_reminder_date => c_reminder_date,
              :c_reminder_interval => c_reminder_interval,
              :c_reminder_notes => c_reminder_notes,
              :c_reminder_type => c_reminder_type,
              :c_activity_date_opened => c_activity_date_opened,
              :c_activity_campaign_name => c_activity_campaign_name,
              :c_activity_activity_type => c_activity_activity_type,
              :c_activity_status => c_activity_status,
              :c_lane_origin => c_lane_origin,
              :c_lane_destination => c_lane_destination,
              :c_lane_id => c_lane_id,
              :c_mc_latest_date_tier => c_mc_latest_date_tier,
              :c_mc_latest_date_load_days =>  c_mc_latest_date_load_days,
              :c_auditable_last_activity_date => c_auditable_last_activity_date
            )

          end
        rescue
        end
      end
    # rescue
    # end
  end

  def reminder(carrier_id)
    begin
      if carrier_id
        @carrier = Carrier.find(carrier_id)

        if @carrier.reminders
          @carrier.reminders.order('updated_at DESC').each do |reminder|
            c_reminder_date = reminder.next_reminder_date

            if c_reminder_date
              c_reminder_interval = reminder.reminder_interval
              c_reminder_id = reminder.id
              c_reminder_notes = reminder.notes
              c_reminder_type = reminder.reminder_type
              c_reminder_completed = reminder.completed

              @carrier.update_attributes(
                :c_reminder_id => c_reminder_id,
                :c_reminder_date => c_reminder_date,
                :c_reminder_interval => c_reminder_interval,
                :c_reminder_notes => c_reminder_notes,
                :c_reminder_type => c_reminder_type
              )
              break
            end
          end
        else
            @carrier.update_attributes(
              :c_reminder_id => nil,
              :c_reminder_date => nil,
              :c_reminder_interval => nil,
              :c_reminder_notes => nil,
              :c_reminder_type => nil
            )
        end

      end
    rescue
    end
  end

  def lane(carrier_id)
    begin
      if carrier_id
        @carrier = Carrier.find(carrier_id)
        lane = CarrierLane.where(:carrier_id => carrier_id).order("created_at DESC").first
        @carrier.update_attributes(:c_lane_origin => lane.lane_origin, :c_lane_destination => lane.lane_destination, :c_lane_id => lane.id)
      end
    rescue
    end
  end

  def activity(carrier_id)
    begin
      if carrier_id
        @carrier = Carrier.find(carrier_id)
        activity = Activity.where(:carrier_id => carrier_id).order("created_at DESC").first
        @carrier.update_attributes(:c_activity_date_opened => activity.date_opened, :c_activity_campaign_name => activity.campaign_name, :c_activity_activity_type => activity.activity_type, :c_activity_status => activity.status)
      end
    rescue
    end
  end


  def carr_new(carrier_id)
    begin
      if carrier_id
        carrier = Carrier.find(carrier_id)
        load_lw = DfLoad.where("ship_date >= DATE_TRUNC('WEEK', NOW()) - INTERVAL '7 DAY' and ship_date < DATE_TRUNC('WEEK', NOW())").where("mc_num = '#{carrier.mc_number}' AND carrier = '#{carrier.company_name.gsub("'"){"\\'"}}'").length
        load_2w = DfLoad.where("ship_date >= DATE_TRUNC('WEEK', NOW()) - INTERVAL '14 DAY' and ship_date < DATE_TRUNC('WEEK', NOW())  - INTERVAL '8 DAY'").where("mc_num = '#{carrier.mc_number}' AND carrier = '#{carrier.company_name.gsub("'"){"\\'"}}'").length
        load_3w = DfLoad.where("ship_date >= DATE_TRUNC('WEEK', NOW()) - INTERVAL '21 DAY' and ship_date < DATE_TRUNC('WEEK', NOW())  - INTERVAL '15 DAY'").where("mc_num = '#{carrier.mc_number}' AND carrier = '#{carrier.company_name.gsub("'"){"\\'"}}'").length
        load_4w = DfLoad.where("ship_date >= DATE_TRUNC('WEEK', NOW()) - INTERVAL '28 DAY' and ship_date < DATE_TRUNC('WEEK', NOW())  - INTERVAL '22 DAY'").where("mc_num = '#{carrier.mc_number}' AND carrier = '#{carrier.company_name.gsub("'"){"\\'"}}'").length
        load_1m = DfLoad.where("ship_date >= DATE_TRUNC('WEEK', NOW()) - INTERVAL '28 DAY' and ship_date < DATE_TRUNC('WEEK', NOW())").where("mc_num = '#{carrier.mc_number}' AND carrier = '#{carrier.company_name.gsub("'"){"\\'"}}'").length
        load_6m = DfLoad.where("ship_date >= DATE_TRUNC('WEEK', NOW()) - INTERVAL '168 DAY' and ship_date < DATE_TRUNC('WEEK', NOW())").where("mc_num = '#{carrier.mc_number}' AND carrier = '#{carrier.company_name.gsub("'"){"\\'"}}'").length

        carrier.update_attributes(:c_carr_new_loads_lw => load_lw, :c_carr_new_loads_2w => load_2w, :c_carr_new_loads_3w => load_3w, :c_carr_new_loads_4w => load_4w, :c_mc_latest_date_last_month => load_1m, :c_mc_latest_date_last_6_months => load_6m)

      end
    rescue
    end
  end

  def mc_latest_date(carrier_id)
    begin
      if carrier_id
        @carrier = Carrier.find(carrier_id)
        mc_latest_date = McLatestDate.select("*, (SELECT (now()::date - ship_date_1::date) FROM mc_latest_date WHERE mcnum = '#{@carrier.mc_number}' ORDER BY ship_date_1 DESC LIMIT 1) AS load_days").where(:mcnum => @carrier.mc_number).order("ship_date_1 DESC").first

        if mc_latest_date
          @carrier.update_attributes(:c_mc_latest_date_tier => mc_latest_date["tier"], :c_mc_latest_date_last_month => mc_latest_date.loadsh_num, :c_mc_latest_date_last_6_months => mc_latest_date.loadsh_num_6mon, :c_mc_latest_date_load_days => mc_latest_date.load_days)
        end
      end
    rescue
    end
  end

  def tier
     Carrier.all.each do |carrier|
         carr_tier = CarrTier.where("mc_number = ? OR mcnum = ? OR mc_number = '%' || ? OR mcnum = '%' || ?", carrier.mc_number, carrier.mc_number, carrier.mc_number, carrier.mc_number).first
         if carr_tier
           carrier.update_attributes(:c_carr_tier_tier => carr_tier["tier"])
         end
     end
  end

  def audit(carrier_id)
    begin
      if carrier_id
        @carrier = Carrier.find(carrier_id)
        audit = Audit.where("((auditable_type = 'Carrier' AND auditable_id IN (#{carrier_id})) OR (auditable_type = 'CarrierCompany' AND auditable_id IN (SELECT carrier_companies.id FROM carrier_companies WHERE carrier_companies.carrier_id = #{carrier_id})) OR (auditable_type = 'CarrierContact' AND auditable_id IN (SELECT carrier_contacts.id FROM carrier_contacts WHERE carrier_contacts.carrier_id = #{carrier_id})) OR (auditable_type = 'CarrierLane' AND auditable_id IN (SELECT carrier_lanes.id FROM carrier_lanes WHERE carrier_lanes.carrier_id = #{carrier_id})) OR (auditable_type = 'CarrierLocation' AND auditable_id IN (SELECT carrier_locations.id FROM carrier_locations WHERE carrier_locations.carrier_id = #{carrier_id})) OR (auditable_type = 'Activity' AND auditable_id IN (SELECT activities.id FROM activities WHERE activities.carrier_id = #{carrier_id})) OR (auditable_type = 'Rate' AND auditable_id IN (SELECT rates.id FROM rates WHERE rates.carrier_id = #{carrier_id})) OR (auditable_type = 'Reminder' AND auditable_id IN (SELECT reminders.id FROM reminders WHERE reminders.carrier_id = #{carrier_id})))").order("created_at DESC").first
        if audit
          @carrier.update_attributes(:c_auditable_last_activity_date => audit.created_at)
        end
      end
    rescue
    end
  end

  def next_reminder_date(reminder)
    reminder_date = reminder.reminder_date
    if reminder.recurring
      reminder_date = reminder.reminder_date_reccuring
    elsif reminder.reminder_interval
      reminder_date = reminder.reminder_date_interval
    end
    reminder.update_attributes(:next_reminder_date => reminder_date)
  end
end
