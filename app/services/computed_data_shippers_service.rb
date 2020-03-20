class ComputedDataShippersService
  def all
    # begin
      Shipper.all.each do |shipper|
        begin
          if shipper
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
            c_auditable_last_activity_date = nil

            # Reminders - START
            shipper.reminders.order('updated_at DESC').each do |reminder|
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
                    else
                      c_reminder_date = reminder.last_reminded
                    end
                  end
                end
              end

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
            activity = Activity.where(:shipper_id => shipper.id).order("created_at DESC").first
            if activity
              c_activity_date_opened = activity.date_opened
              c_activity_campaign_name = activity.campaign_name
              c_activity_activity_type = activity.activity_type
              c_activity_status = activity.status
            end
            # Activities - END

            # Lanes - START
            lane = ShipperLane.where(:shipper_id => shipper.id).order("created_at DESC").first
            if lane
              c_lane_origin = lane.lane_origin
              c_lane_destination = lane.lane_destination
              c_lane_id = lane.id
            end
            # Lanes - END

            # Audit - START
            audit = Audit.where("((auditable_type = 'Shipper' AND auditable_id IN (#{shipper.id})) OR (auditable_type = 'ShipperCompany' AND auditable_id IN (SELECT shipper_companies.id FROM shipper_companies WHERE shipper_companies.shipper_id = #{shipper.id})) OR (auditable_type = 'ShipperContact' AND auditable_id IN (SELECT shipper_contacts.id FROM shipper_contacts WHERE shipper_contacts.shipper_id = #{shipper.id})) OR (auditable_type = 'ShipperLane' AND auditable_id IN (SELECT shipper_lanes.id FROM shipper_lanes WHERE shipper_lanes.shipper_id = #{shipper.id})) OR (auditable_type = 'ShipperLocation' AND auditable_id IN (SELECT shipper_locations.id FROM shipper_locations WHERE shipper_locations.shipper_id = #{shipper.id})) OR (auditable_type = 'Activity' AND auditable_id IN (SELECT activities.id FROM activities WHERE activities.shipper_id = #{shipper.id})) OR (auditable_type = 'Rate' AND auditable_id IN (SELECT rates.id FROM rates WHERE rates.shipper_id = #{shipper.id})) OR (auditable_type = 'Reminder' AND auditable_id IN (SELECT reminders.id FROM reminders WHERE reminders.shipper_id = #{shipper.id})))").order("created_at DESC").first
            if audit
              c_auditable_last_activity_date = audit.created_at
            end
            # Audit - END

            # Update Shipper
            shipper.update_attributes(
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
              :c_auditable_last_activity_date => c_auditable_last_activity_date
            )
          end
        rescue
        end
      end
    # rescue
    # end
  end

  def reminder(shipper_id)
    begin
      if shipper_id
        @shipper = Shipper.find(shipper_id)

        if @shipper.reminders
          @shipper.reminders.order('updated_at DESC').each do |reminder|
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
                  else
                    c_reminder_date = reminder.last_reminded
                  end
                end
              end
            end

            if c_reminder_date
              c_reminder_interval = reminder.reminder_interval
              c_reminder_id = reminder.id
              c_reminder_notes = reminder.notes
              c_reminder_type = reminder.reminder_type

              @shipper.update_attributes(
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
            @shipper.update_attributes(
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

  def lane(shipper_id)
    begin
      if shipper_id
        @shipper = Shipper.find(shipper_id)
        lane = ShipperLane.where(:shipper_id => shipper_id).order("created_at DESC").first
        @shipper.update_attributes(:c_lane_origin => lane.lane_origin, :c_lane_destination => lane.lane_destination, :c_lane_id => lane.id)
      end
    rescue
    end
  end

  def activity(shipper_id)
    begin
      if shipper_id
        @shipper = Shipper.find(shipper_id)
        activity = Activity.where(:shipper_id => shipper_id).order("created_at DESC").first
        @shipper.update_attributes(:c_activity_date_opened => activity.date_opened, :c_activity_campaign_name => activity.campaign_name, :c_activity_activity_type => activity.activity_type, :c_activity_status => activity.status)
      end
    rescue
    end
  end

  def audit(shipper_id)
    begin
      if shipper_id
        @shipper = Shipper.find(shipper_id)
        audit = Audit.where("((auditable_type = 'Shipper' AND auditable_id IN (#{shipper_id})) OR (auditable_type = 'ShipperCompany' AND auditable_id IN (SELECT shipper_companies.id FROM shipper_companies WHERE shipper_companies.shipper_id = #{shipper_id})) OR (auditable_type = 'ShipperContact' AND auditable_id IN (SELECT shipper_contacts.id FROM shipper_contacts WHERE shipper_contacts.shipper_id = #{shipper_id})) OR (auditable_type = 'ShipperLane' AND auditable_id IN (SELECT shipper_lanes.id FROM shipper_lanes WHERE shipper_lanes.shipper_id = #{shipper_id})) OR (auditable_type = 'ShipperLocation' AND auditable_id IN (SELECT shipper_locations.id FROM shipper_locations WHERE shipper_locations.shipper_id = #{shipper_id})) OR (auditable_type = 'Activity' AND auditable_id IN (SELECT activities.id FROM activities WHERE activities.shipper_id = #{shipper_id})) OR (auditable_type = 'Rate' AND auditable_id IN (SELECT rates.id FROM rates WHERE rates.shipper_id = #{shipper_id})) OR (auditable_type = 'Reminder' AND auditable_id IN (SELECT reminders.id FROM reminders WHERE reminders.shipper_id = #{shipper_id})))").order("created_at DESC").first
        if audit
          @shipper.update_attributes(:c_auditable_last_activity_date => audit.created_at)
        end
      end
    rescue
    end
  end
end
