class ShipperDatatable < AjaxDatatablesRails::ActiveRecord
  include ApplicationHelper
  extend Forwardable

  def_delegator :@view, :check_box_tag
  def_delegator :@view, :link_to
  def_delegator :@view, :shipper_path
  def_delegator :@view, :user_path

  def initialize(params, opts = {})
    @view = opts[:view_context]
    super
  end

  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format
    @view_columns ||= {
      id: { source: "Shipper.id", cond: filter_on_id },
      c_reminder_date: { source: "Shipper.c_reminder_date", cond: filter_on_date },
      relationship_owner_name: { source: "Shipper.relationship_owner", cond: filter_for_relationship_owner_initials },
      sales_priority: { source: "Shipper.sales_priority", cond: filter_on_numbers },
      company_name: { source: "Shipper.company_name", cond: filter_on_string },
      state: { source: "state", cond: filter_on_state },
      pdm_name: { source: "pdm_name", cond: filter_on_pdm_name },
      primary_phone: { source: "primary_phone", cond: filter_on_primary_phone },
      c_lane_origin: { source: "Shipper.c_lane_origin", cond: filter_on_lane },
      contact_email: { source: "contact_email", cond: filter_on_contact_email },
      approved: { source: "Shipper.approved", cond: filter_on_boolean },
      complete_record: { source: "Shipper.complete_record", cond: filter_on_boolean },
      date_opened: { source: "Shipper.c_activity_date_opened", cond: filter_on_date },
      load_last_month: { source: "Shipper.load_last_month", cond: filter_on_numbers },
      load_last_6_month: { source: "Shipper.load_last_6_month", cond: filter_on_numbers },
      city: { source: "city", cond: filter_on_city },
      loads_per_month: { source: "Shipper.loads_per_month", cond: filter_on_numbers },
      commodities: { source: "Shipper.commodities", cond: filter_on_string },
    }
  end

  def data
    records.map do |record|
      {
        id: check_box_tag('shippers[]', record.id),
        c_reminder_date: record.c_reminder_date ? format_reminder(record.c_reminder_id, record.c_reminder_date, record.c_reminder_type, record.c_reminder_notes, record.c_reminder_completed).html_safe : "",
        relationship_owner_name: record.relationship_owner_name ? (record['relationship_owner_name'].blank? ? '(no name)' : "#{link_to(covert_initials(record['relationship_owner_name']), user_path(:id => record['relationship_owner']))}".html_safe) : '',
        sales_priority: shade_sales_priority(record.sales_priority).html_safe,
        company_name: record.decorate.link_to,
        state: record.state,
        pdm_name: record.pdm_name,
        primary_phone: record.primary_phone.nil? ? '' : generate_phone_number("", record.primary_phone, record.primary_extension_number, record.primary_eligible_texting, record.primary_phone_type).html_safe,
        c_lane_origin: record.decorate.lanes,
        contact_email: !record.contact_email.nil? ? "<a href='mailto:#{record.contact_email}?Subject=Hello%20#{record.pdm_name.nil? ? '' :  record.pdm_name.titleize}' target='_top'>#{record.contact_email.downcase}&nbsp;<i class='far fa-envelope'></i></a>".html_safe : "",
        approved: record.approved ? "<b class='text-success'>Y</b>".html_safe : "<i class='text-danger'>N</i>".html_safe,
        complete_record: record.complete_record ? "<b class='text-success'>Y</b>".html_safe : "<i class='text-danger'>N</i>".html_safe,
        date_opened: record.c_activity_date_opened.nil? ? "" : record.c_activity_date_opened.strftime('%m/%d/%Y').to_s,
        load_last_month: record.load_last_month,
        load_last_6_month: record.load_last_6_month,
        city: record.city,
        loads_per_month: record.loads_per_month,
        commodities: record.decorate.commodities
        # name: record.name
      }
    end
  end

  def get_raw_records
    # insert query here
    Shipper.all
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
        ::Arel::Nodes::SqlLiteral.new("shippers.id").eq(column.search.value)
      else
        search_value = URI.unescape(column.search.value)
        ::Arel::Nodes::SqlLiteral.new("CAST(shippers.#{column.field.to_s} AS VARCHAR)").matches("%#{search_value}%")
      end
    }
  end

  def filter_on_string
    ->(column, value) {
      search_value = URI.unescape(column.search.value)
      ::Arel::Nodes::SqlLiteral.new("CAST(shippers.#{column.field.to_s} AS VARCHAR)").matches("%#{search_value}%")
    }
  end

  def filter_on_boolean
    ->(column, value) {
      if is_numeric?(column.search.value) && column.search.value.to_i < 2
        ::Arel::Nodes::SqlLiteral.new("shippers.#{column.field.to_s}").eq(column.search.value)
      else
        search_value = URI.unescape(column.search.value)
        ::Arel::Nodes::SqlLiteral.new("CAST(shippers.#{column.field.to_s} AS VARCHAR)").matches("%#{search_value}%")
      end
    }
  end


  def filter_on_date
    ->(column, value) {
      date_value = column.search.value.tr('/', '-')
      search_value = URI.unescape(date_value)
      ::Arel::Nodes::SqlLiteral.new("CAST(shippers.#{column.field.to_s} AS VARCHAR)").matches("%#{
          search_value}%")
    }
  end

  def filter_on_numbers
    ->(column, value) {
      search_value = URI.unescape(column.search.value)
      if is_numeric?(column.search.value)
        ::Arel::Nodes::SqlLiteral.new("shippers.#{column.field.to_s}").eq(search_value)
      else
        ::Arel::Nodes::SqlLiteral.new("CAST(shippers.#{column.field.to_s} AS VARCHAR)").matches("%#{search_value}%")
      end
    }
  end

  def filter_on_lane
    ->(column, value) {
      data_values = column.search.value.split("-")
      if data_values.length > 1
         data_column_0 = data_values[0].split(" ")
         data_column_1 = data_values[1].split(" ")
         data_value_0_sql_script = nil
         data_value_1_sql_script = nil
         if data_column_0.length > 1
           data_column_0.each do |dc|
             if data_value_0_sql_script.nil?
               data_value_0_sql_script = Arel::Nodes::Or.new(
                               Arel::Nodes::SqlLiteral.new("shippers.c_lane_origin").matches("%#{dc.strip}%"),
                               Arel::Nodes::SqlLiteral.new("shippers.c_lane_destination").matches("%#{dc.strip}%")
                             )
             else
               data_value_0_sql_script = Arel::Nodes::Or.new(
                               data_value_0_sql_script,
                               Arel::Nodes::Or.new(
                                               Arel::Nodes::SqlLiteral.new("shippers.c_lane_origin").matches("%#{dc.strip}%"),
                                               Arel::Nodes::SqlLiteral.new("shippers.c_lane_destination").matches("%#{dc.strip}%")
                                             )
                             )
             end
           end
         else
           data_value_0_sql_script =   Arel::Nodes::Or.new(
                             Arel::Nodes::SqlLiteral.new("shippers.c_lane_origin").matches("%#{data_values[0].strip}%"),
                             Arel::Nodes::SqlLiteral.new("shippers.c_lane_destination").matches("%#{data_values[0].strip}%")
                           )
         end
         if data_column_1.length > 1
           data_column_1.each do |dc|
             if data_value_1_sql_script.nil?
               data_value_1_sql_script = Arel::Nodes::Or.new(
                               Arel::Nodes::SqlLiteral.new("shippers.c_lane_origin").matches("%#{dc.strip}%"),
                               Arel::Nodes::SqlLiteral.new("shippers.c_lane_destination").matches("%#{dc.strip}%")
                             )
             else
               data_value_1_sql_script = Arel::Nodes::Or.new(
                               data_value_1_sql_script,
                               Arel::Nodes::Or.new(
                                               Arel::Nodes::SqlLiteral.new("shippers.c_lane_origin").matches("%#{dc.strip}%"),
                                               Arel::Nodes::SqlLiteral.new("shippers.c_lane_destination").matches("%#{dc.strip}%")
                                             )
                             )
             end
           end
         else
           data_value_1_sql_script =   Arel::Nodes::Or.new(
                             Arel::Nodes::SqlLiteral.new("shippers.c_lane_origin").matches("%#{data_values[1].strip}%"),
                             Arel::Nodes::SqlLiteral.new("shippers.c_lane_destination").matches("%#{data_values[1].strip}%")
                           )
         end
         ::Arel::Nodes::And.new(
           [
             Arel::Nodes::Grouping.new(
               data_value_0_sql_script
             ),
             Arel::Nodes::Grouping.new(
               data_value_1_sql_script
             )
           ]
         )
      else
        data_column_0 = data_values[0].split(" ")
        puts "data_column_0.length::: #{data_column_0.length}"
        data_value_0_sql_script = nil
        if data_column_0.length > 1
          data_column_0.each do |dc|
            if data_value_0_sql_script.nil?
              data_value_0_sql_script = Arel::Nodes::Or.new(
                              Arel::Nodes::SqlLiteral.new("shippers.c_lane_origin").matches("%#{dc.strip}%"),
                              Arel::Nodes::SqlLiteral.new("shippers.c_lane_destination").matches("%#{dc.strip}%")
                            )
            else
              data_value_0_sql_script = Arel::Nodes::Or.new(
                              data_value_0_sql_script,
                              Arel::Nodes::Or.new(
                                              Arel::Nodes::SqlLiteral.new("shippers.c_lane_origin").matches("%#{dc.strip}%"),
                                              Arel::Nodes::SqlLiteral.new("shippers.c_lane_destination").matches("%#{dc.strip}%")
                                            )
                            )
            end
          end
        else
          data_value_0_sql_script =   Arel::Nodes::Or.new(
                            Arel::Nodes::SqlLiteral.new("shippers.c_lane_origin").matches("%#{data_values[0].strip}%"),
                            Arel::Nodes::SqlLiteral.new("shippers.c_lane_destination").matches("%#{data_values[0].strip}%")
                          )
        end
        ::Arel::Nodes::Grouping.new(
          data_value_0_sql_script
        )
      end
    }
  end

    def filter_on_state
      ->(column, value) { ::Arel::Nodes::SqlLiteral.new("locations.state").matches("%#{column.search.value}%") }
    end

    def filter_on_city
      ->(column, value) { ::Arel::Nodes::SqlLiteral.new("locations.city").matches("%#{column.search.value}%") }
    end

    def filter_on_primary_phone
      ->(column, value) { ::Arel::Nodes::SqlLiteral.new("contacts.primary_phone").matches("%#{column.search.value}%") }
    end

    def filter_on_contact_email
      ->(column, value) { ::Arel::Nodes::SqlLiteral.new("contacts.email").matches("%#{column.search.value}%") }
    end

    def filter_on_pdm_name
      ->(column, value) { ::Arel::Nodes::SqlLiteral.new("CONCAT(contacts.first_name, ' ', contacts.last_name)").matches("%#{column.search.value}%") }
    end

    def filter_for_relationship_owner_initials
      ->(column, value) { ::Arel::Nodes::SqlLiteral.new("CONCAT(SUBSTR(relationship_owner_user.first_name, 1, 1), SUBSTR(relationship_owner_user.last_name, 1, 1))").matches("%#{column.search.value}%") }
    end

end
