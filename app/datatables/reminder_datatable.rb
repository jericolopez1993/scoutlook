class ReminderDatatable < AjaxDatatablesRails::ActiveRecord
  include ApplicationHelper
  include ActionView::Helpers::NumberHelper
  extend Forwardable
  require 'uri'

  def_delegator :@view, :check_box_tag
  def_delegator :@view, :link_to
  def_delegator :@view, :carrier_path
  def_delegator :@view, :user_path

  def initialize(params, opts = {})
    @view = opts[:view_context]
    super
  end

  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format
    @view_columns ||= {
      id: { source: "Reminder.id", cond: filter_on_id },
      carrier_id: { source: "Reminder.carrier_id", cond: filter_on_carrier_company_name },
      carrier_name: { source: "carrier_name", cond: filter_on_carrier_company_name },
      shipper_id: { source: "Reminder.shipper_id", cond: filter_on_shipper_company_name },
      shipper_name: { source: "shipper_name", cond: filter_on_shipper_company_name },
      activity_id: { source: "Reminder.activity_id", cond: filter_on_activities_campaign_name },
      campaign_name: { source: "campaign_name", cond: filter_on_activities_campaign_name },
      user_id: { source: "Reminder.user_id", cond: filter_on_string },
      user_name: { source: "user_name", cond: filter_on_user_name },
      reminder_type: { source: "Reminder.reminder_type", cond: filter_on_string },
      reminder_date: { source: "Reminder.reminder_date", cond: filter_on_date },
      next_reminder_date: { source: "Reminder.next_reminder_date", cond: filter_on_date },
      reminder_interval: { source: "Reminder.reminder_interval", cond: filter_on_numbers },
      recurring: { source: "Reminder.recurring", cond: filter_on_boolean },
      last_reminded: { source: "Reminder.last_reminded", cond: filter_on_date },
      notes: { source: "Reminder.notes", cond: filter_on_string },
      completed: { source: "Reminder.completed", cond: filter_on_boolean },
      created_at: { source: "Reminder.created_at", cond: filter_on_date }
    }
  end

  def data
    records.map do |record|
      {
        actions: record.decorate.dt_actions,
        id: record.id,
        carrier_id: record.decorate.link_to_carrier,
        shipper_id: record.decorate.link_to_shipper,
        campaign_name: record.activity_id ? (record['campaign_name'].blank? ? '(no name)' : "#{link_to(record['campaign_name'], activity_path(:id => record['activity_id']))}".html_safe) : '',
        user_name: record.user_id ? (record['user_name'].blank? ? '(no name)' : "#{link_to(record['user_name'], user_path(:id => record['user_id']))}".html_safe) : '',
        reminder_type: record.reminder_type,
        reminder_date: record.decorate.next_reminder_date,
        next_reminder_date: Reminder.compute_next_reminder_date(record),
        last_reminded: record.last_reminded ? record.last_reminded.strftime('%m/%d/%Y %l:%M %p') : '',
        notes: record.decorate.notes,
        completed: record.completed ? "<i class='text-success'>Yes</i>".html_safe : "<i class='text-danger'>No</i>".html_safe,
        created_at: record.created_at.strftime('%m/%d/%Y %l:%M %p')
      }
    end
  end

  def get_raw_records
    # insert query here
    # if user.has_role?(:carrier_development)
    #   Reminder.listings.where("reminders.user_id = #{user.id}")
    # else
    Reminder.listings
    # end
  end

  def user
    @user ||= options[:user]
  end

  def is_numeric?(obj)
   obj.to_s.match(/\A[+-]?\d+?(\.\d+)?\Z/) == nil ? false : true
  end

  def filter_on_id
    ->(column, value) {
      if is_numeric?(column.search.value)
        ::Arel::Nodes::SqlLiteral.new("reminders.id").eq(column.search.value)
      else
        search_value = URI.unescape(column.search.value)
        ::Arel::Nodes::SqlLiteral.new("CAST(reminders.#{column.field.to_s} AS VARCHAR)").matches("%#{search_value}%")
      end
    }
  end

  def filter_on_string
    ->(column, value) {
      search_value = URI.unescape(column.search.value)
      ::Arel::Nodes::SqlLiteral.new("CAST(reminders.#{column.field.to_s} AS VARCHAR)").matches("%#{search_value}%")
    }
  end

  def filter_on_boolean
    ->(column, value) {
      if is_numeric?(column.search.value) && column.search.value.to_i < 2
        ::Arel::Nodes::SqlLiteral.new("reminders.#{column.field.to_s}").eq(column.search.value)
      else
        search_value = URI.unescape(column.search.value)
        ::Arel::Nodes::SqlLiteral.new("CAST(reminders.#{column.field.to_s} AS VARCHAR)").matches("%#{search_value}%")
      end
    }
  end


  def filter_on_date
    ->(column, value) {
      date_value = column.search.value.tr('/', '-')
      search_value = URI.unescape(date_value)
      ::Arel::Nodes::SqlLiteral.new("CAST(reminders.#{column.field.to_s} AS VARCHAR)").matches("%#{
          search_value}%")
    }
  end

  def filter_on_range
    ->(column, value) {
      data_values = column.search.value.split("-yadcf_delim-")
      column_name = "reminders.#{column.field.to_s}"
      if is_numeric?(data_values[0]) || is_numeric?(data_values[1])
      ::Arel::Nodes::Between.new(
          Arel.sql(column_name),
          Arel::Nodes::And.new(
            [
              data_values[0] ? data_values[0].to_i : 0,
              data_values[1] ? data_values[1].to_i : 99999
            ]
          )
        )
      else
        search_value = URI.unescape(column.search.value)
        if search_value != "-yadcf_delim-"
        ::Arel::Nodes::SqlLiteral.new("CAST(reminders.#{column.field.to_s} AS VARCHAR)").matches("%#{search_value}%")
        end
      end
    }
  end

  def filter_on_numbers
    ->(column, value) {
      search_value = URI.unescape(column.search.value)
      if is_numeric?(column.search.value)
        ::Arel::Nodes::SqlLiteral.new("reminders.#{column.field.to_s}").eq(search_value)
      else
        ::Arel::Nodes::SqlLiteral.new("CAST(reminders.#{column.field.to_s} AS VARCHAR)").matches("%#{search_value}%")
      end
      # if (column.search.value && column.search.value != 0 && column.search.value !=  "0")
      #   "reminders.#{column.field.to_s.gsub("current_", "")} <> 0 AND reminders.#{column.field.to_s.gsub("current_", "")} = #{column.search.value}"
      # else
      #   "reminders.#{column.field.to_s.gsub("current_", "")} = #{column.search.value}"
      # end
    }
  end

  def filter_on_user_name
    ->(column, value) {
      search_value = URI.unescape(column.search.value)
      ::Arel::Nodes::SqlLiteral.new("CONCAT(users.first_name, ' ', users.last_name)").matches("%#{search_value}%")
     }
  end

  def filter_on_carrier_company_name
    ->(column, value) {
      search_value = URI.unescape(column.search.value)
      ::Arel::Nodes::SqlLiteral.new("carriers.company_name").matches("%#{search_value}%")
     }
  end

  def filter_on_shipper_company_name
    ->(column, value) {
      search_value = URI.unescape(column.search.value)
      ::Arel::Nodes::SqlLiteral.new("shippers.company_name").matches("%#{search_value}%")
     }
  end

  def filter_on_activities_campaign_name
    ->(column, value) {
      search_value = URI.unescape(column.search.value)
      ::Arel::Nodes::SqlLiteral.new("activities.campaign_name").matches("%#{search_value}%")
     }
  end

  def filter_for_relationship_owner_initials
    ->(column, value) {
      search_value = URI.unescape(column.search.value)
      ::Arel::Nodes::SqlLiteral.new("CONCAT(SUBSTR(relationship_owner_user.first_name, 1, 1), SUBSTR(relationship_owner_user.last_name, 1, 1))").matches("%#{search_value}%")
    }
  end

  def as_json(options = {})
      {
        :draw => params[:draw].to_i,
        :recordsTotal =>  get_raw_records.length,
        :recordsFiltered => filter_records(get_raw_records).length,
        :data => data

      }
  end

end
