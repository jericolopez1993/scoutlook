class ActivityDatatable < AjaxDatatablesRails::ActiveRecord
  include ApplicationHelper
  include ActionView::Helpers::NumberHelper
  extend Forwardable

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
      id: { source: "Activity.id", cond: filter_on_id},
      sp: { source: "user_name_initials", cond: filter_on_sp },
      name: { source: "current_name", cond: filter_on_name },
      location_state: { source: "location_state", cond: filter_on_location_state },
      loads_per_week: { source: "Activity.loads_per_week", cond: filter_on_numbers },
      date_opened: { source: "Activity.date_opened", cond: filter_on_boolean },
      date_closed: { source: "Activity.date_closed", cond: filter_on_boolean },
      outcome: { source: "Activity.outcome", cond: filter_on_id },
      notes: { source: "Activity.notes", cond: filter_on_string },
      activity_type: { source: "Activity.activity_type", cond: filter_on_string },
      status: { source: "Activity.status", cond: filter_on_string },
      reason: { source: "Activity.reason", cond: filter_on_string }
    }
  end

  def data
    records.map do |record|
      {
        actions: record.decorate.dt_actions,
        id: record.id,
        sp: record.user_id ? (record['user_name_initials'].blank? ? '(no name)' : "#{link_to(record['user_name_initials'], user_path(:id => record['user_id']))}".html_safe) : '',
        name: record.carrier_id ? record.decorate.link_to_carrier : (record.shipper_id ? record.decorate.link_to_shipper : ""),
        location_state: record['location_state'],
        loads_per_week: record.loads_per_week,
        date_opened: convert_date(record.date_opened),
        date_closed: convert_date(record.date_closed),
        outcome: record.outcome,
        notes: record.decorate.notes,
        activity_type: record.activity_type,
        status: record.status ? 'Open' : 'Closed',
        reason: record.reason
      }
    end
  end

  def get_raw_records
    # insert query here
    Activity.listings
  end

  def is_numeric?(obj)
   obj.to_s.match(/\A[+-]?\d+?(\.\d+)?\Z/) == nil ? false : true
  end

  def filter_on_id
    ->(column, value) {
      if is_numeric?(column.search.value)
        ::Arel::Nodes::SqlLiteral.new("activities.id").eq(column.search.value)
      else
        search_value = URI.unescape(column.search.value)
        ::Arel::Nodes::SqlLiteral.new("CAST(activities.#{column.field.to_s} AS VARCHAR)").matches("%#{search_value}%")
      end
    }
  end

  def filter_on_string
    ->(column, value) {
      search_value = URI.unescape(column.search.value)
      ::Arel::Nodes::SqlLiteral.new("CAST(activities.#{column.field.to_s} AS VARCHAR)").matches("%#{search_value}%")
    }
  end

  def filter_on_boolean
    ->(column, value) {
      if is_numeric?(column.search.value) && column.search.value.to_i < 2
        ::Arel::Nodes::SqlLiteral.new("activities.#{column.field.to_s}").eq(column.search.value)
      else
        search_value = URI.unescape(column.search.value)
        ::Arel::Nodes::SqlLiteral.new("CAST(activities.#{column.field.to_s} AS VARCHAR)").matches("%#{search_value}%")
      end
    }
  end


  def filter_on_date
    ->(column, value) {
      date_value = column.search.value.tr('/', '-')
      search_value = URI.unescape(date_value)
      ::Arel::Nodes::SqlLiteral.new("CAST(activities.#{column.field.to_s} AS VARCHAR)").matches("%#{
          search_value}%")
    }
  end

  def filter_on_numbers
    ->(column, value) {
      search_value = URI.unescape(column.search.value)
      if is_numeric?(column.search.value)
        ::Arel::Nodes::SqlLiteral.new("activities.#{column.field.to_s}").eq(search_value)
      else
        ::Arel::Nodes::SqlLiteral.new("CAST(activities.#{column.field.to_s} AS VARCHAR)").matches("%#{search_value}%")
      end
    }
  end

  def filter_on_sp
    ->(column, value) { ::Arel::Nodes::SqlLiteral.new("CONCAT(users.first_name, ' ', users.last_name)").matches("%#{column.search.value}%") }
  end

  def filter_on_name
    ->(column, value) { ::Arel::Nodes::SqlLiteral.new("COALESCE(carriers.company_name, shippers.company_name)").matches("%#{column.search.value}%") }
  end

  def filter_on_location_state
    ->(column, value) { ::Arel::Nodes::SqlLiteral.new("COALESCE(carrier_locations.state, shipper_locations.state)").matches("%#{column.search.value}%") }
  end

end
