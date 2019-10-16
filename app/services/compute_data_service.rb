class ComputeDataService
  def reminder(carrier_id)
    if carrier_id
      @carrier = Carrier.find(carrier_id)

      @carrier.reminders.order('updated_at DESC').each do |reminder|
        c_reminder_date = nil
        if reminder.recurring
          if reminder.last_reminded
            current_date = reminder.last_reminded
            if current_date <= Date.today
              if current_date == Date.today
                c_reminder_date = current_date
              end
              until current_date >= Date.today
                current_date += reminder.reminder_interval.days
              end
              if reminder.reminder_interval > 0 && current_date > Date.today
                c_reminder_date = current_date
              end
            else
              c_reminder_date = reminder.reminder_date
            end

          elsif reminder.reminder_date
            current_date = reminder.reminder_date
            if current_date == Date.today
              c_reminder_date = current_date
            end
            until current_date >= Date.today
              current_date += reminder.reminder_interval.days
            end
            if reminder.reminder_interval > 0 && current_date > Date.today
              c_reminder_date = current_date
            end
          else
            current_date = reminder.created_at
            until current_date >= Date.today
              current_date += reminder.reminder_interval.days
            end
            if current_date >= Date.today
              c_reminder_date = reminder.current_date
            end
          end
        else
          if reminder.reminder_interval > 0
            if reminder.reminder_date
              quot = ((Date.today.to_date - reminder.reminder_date.to_date).to_i / reminder.reminder_interval)
              if quot >= 1 && reminder.reminder_date >= Date.today
                c_reminder_date = reminder.reminder_date
              else
                if (reminder.reminder_date + reminder.reminder_interval.days) == Date.today.to_date
                  c_reminder_date = Date.today
                end
              end
            else
              c_reminder_date = reminder.created_at + reminder.reminder_interval.days
            end
          else
            if reminder.reminder_date
              if reminder.reminder_date >= Date.today
                c_reminder_date = reminder.reminder_date
              end
            end
          end
        end

        if c_reminder_date
          c_reminder_interval = reminder.reminder_interval
          c_reminder_id = reminder.id
          c_reminder_notes = reminder.notes
          c_reminder_type = reminder.reminder_type

          @carrier.update_attributes(:c_reminder_id => c_reminder_id, :c_reminder_date => c_reminder_date, :c_reminder_interval => c_reminder_interval, :c_reminder_notes => c_reminder_notes, :c_reminder_type => c_reminder_type)
          break
        end

      end
    end
  end

  def lane(carrier_id)
    if carrier_id
      @carrier = Carrier.find(carrier_id)
      lane = CarrierLane.where(:carrier_id => carrier_id).order("created_at DESC").first
      @carrier.update_attributes(:c_lane_origin => lane.lane_origin, :c_lane_destination => lane.lane_destination, :c_lane_id => lane.id)
    end
  end

  def mc_latest_date(carrier_id)
    if carrier_id
      @carrier = Carrier.find(carrier_id)
      mc_latest_date = McLatestDate.select("*, (SELECT (now()::date - ship_date_1::date) FROM mc_latest_date WHERE mcnum = '#{@carrier.mc_number}' ORDER BY ship_date_1 DESC LIMIT 1) AS load_days").where(:mcnum => @carrier.mc_number).order("ship_date_1 DESC").first

      if mc_latest_date
        @carrier.update_attributes(:c_mc_latest_date_tier => mc_latest_date["tier"], :c_mc_latest_date_last_month => mc_latest_date.loadsh_num, :c_mc_latest_date_last_6_months => mc_latest_date.loadsh_num_6mon, :c_mc_latest_date_load_days => mc_latest_date.load_days)
      end
    end
  end

  def audit(carrier_id)
    if carrier_id
      @carrier = Carrier.find(carrier_id)
      audit = Audit.where("((auditable_type = 'Carrier' AND auditable_id IN (#{carrier_id})) OR (auditable_type = 'CarrierCompany' AND auditable_id IN (SELECT carrier_companies.id FROM carrier_companies WHERE carrier_companies.carrier_id = #{carrier_id})) OR (auditable_type = 'CarrierContact' AND auditable_id IN (SELECT carrier_contacts.id FROM carrier_contacts WHERE carrier_contacts.carrier_id = #{carrier_id})) OR (auditable_type = 'CarrierLane' AND auditable_id IN (SELECT carrier_lanes.id FROM carrier_lanes WHERE carrier_lanes.carrier_id = #{carrier_id})) OR (auditable_type = 'CarrierLocation' AND auditable_id IN (SELECT carrier_locations.id FROM carrier_locations WHERE carrier_locations.carrier_id = #{carrier_id})) OR (auditable_type = 'Activity' AND auditable_id IN (SELECT activities.id FROM activities WHERE activities.carrier_id = #{carrier_id})) OR (auditable_type = 'Rate' AND auditable_id IN (SELECT rates.id FROM rates WHERE rates.carrier_id = #{carrier_id})) OR (auditable_type = 'Reminder' AND auditable_id IN (SELECT reminders.id FROM reminders WHERE reminders.carrier_id = #{carrier_id})))").order("created_at DESC").first
      if audit
        @carrier.update_attributes(:c_auditable_last_activity_date => audit.created_at)
      end
    end
  end
end
