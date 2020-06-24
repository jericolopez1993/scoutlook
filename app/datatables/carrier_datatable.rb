class CarrierDatatable < AjaxDatatablesRails::ActiveRecord
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
      id: { source: "Carrier.id", cond: filter_on_id },
      c_reminder_date: { source: "Carrier.c_reminder_date", cond: filter_on_date },
      interview: { source: "Carrier.interview", cond: filter_on_boolean },
      wolfbyte: { source: "Carrier.wolfbyte", cond: filter_on_boolean },
      relationship_owner_name: { source: "relationship_owner_name", cond: filter_for_relationship_owner_initials },
      sales_priority: { source: "Carrier.sales_priority", cond: filter_on_string },
      mc_number: { source: "Carrier.mc_number", cond: filter_on_string },
      company_name: { source: "Carrier.company_name", cond: filter_on_string },
      power_units: { source: "Carrier.power_units", cond: filter_on_numbers },
      reefers: { source: "Carrier.reefers", cond: filter_on_range },
      teams: { source: "Carrier.teams", cond: filter_on_range },
      c_mc_latest_date_load_days: { source: "Carrier.c_mc_latest_date_load_days", cond: filter_on_range },
      tier: { source: "Carrier.c_mc_latest_date_tier", cond: filter_on_tier },
      loads_lw: { source: "Carrier.c_carr_new_loads_lw", cond: filter_on_range },
      c_mc_latest_date_last_month: { source: "Carrier.c_mc_latest_date_last_month", cond: filter_on_range },
      c_mc_latest_date_last_6_months: { source: "Carrier.c_mc_latest_date_last_6_months", cond: filter_on_range },
      c_lane_origin: { source: "Carrier.c_lane_origin", cond: filter_on_lane },
      c_lane_destination: { source: "Carrier.c_lane_destination" },
      blacklisted: { source: "Carrier.blacklisted", cond: filter_on_boolean },
      poc_name: {source: "poc_name", cond: filter_on_poc_name},
      primary_phone: { source: "primary_phone", cond: filter_on_primary_phone },
      contact_email: {source: "contact_email", cond: filter_on_contact_email},
      approved: { source: "Carrier.approved", cond: filter_on_boolean },
      complete_record: { source: "Carrier.complete_record", cond: filter_on_boolean },
      date_opened: { source: "Carrier.c_activity_date_opened", cond: filter_on_date }
    }
  end

  def data
    records.map do |record|
      {
        id: check_box_tag('carriers[]', record.id),
        c_reminder_date: record.c_reminder_date ? format_reminder(record.c_reminder_id, record.c_reminder_date, record.c_reminder_type, record.c_reminder_notes, record.c_reminder_completed).html_safe : "",
        interview: record.interview ? "<i class='text-success'>Yes</i>".html_safe : "<i class='text-danger'>No</i>".html_safe,
        wolfbyte: record.wolfbyte ? "<i class='text-success'>Yes</i>".html_safe : "<i class='text-danger'>No</i>".html_safe,
        relationship_owner_name: record.relationship_owner_name ? (record['relationship_owner_name'].blank? ? '(no name)' : "#{link_to(covert_initials(record['relationship_owner_name']), user_path(:id => record['relationship_owner']))}".html_safe) : '',
        sales_priority: shade_sales_priority(record.sales_priority).html_safe,
        mc_number: record.decorate.mc_number,
        company_name: record.decorate.truncate_link_to,
        power_units: record.power_units && record.power_units > 0 ? record.power_units : "",
        reefers: record.reefers && record.reefers > 0 ? record.reefers : "",
        teams: record.teams && record.teams > 0 ? record.teams : "",
        c_mc_latest_date_load_days: record.c_mc_latest_date_load_days && record.c_mc_latest_date_load_days > 0 ? record.c_mc_latest_date_load_days : "",
        tier: generate_rank_text(record.c_mc_latest_date_tier).html_safe,
        loads_lw: record.c_carr_new_loads_lw,
        c_mc_latest_date_last_month: record.c_mc_latest_date_last_month && record.c_mc_latest_date_last_month > 0 ? record.c_mc_latest_date_last_month : "",
        c_mc_latest_date_last_6_months: record.c_mc_latest_date_last_6_months && record.c_mc_latest_date_last_6_months > 0 ? record.c_mc_latest_date_last_6_months : "",
        c_lane_origin: record.decorate.lanes,
        blacklisted: record.blacklisted ? "<i class='text-danger'>Yes</i>".html_safe : "<i class='text-success'>No</i>".html_safe,
        poc_name: record.poc_name,
        primary_phone: record.primary_phone.nil? ? '' : generate_phone_number("", record.primary_phone, record.primary_extension_number, record.primary_eligible_texting, record.primary_phone_type).html_safe,
        contact_email: !record.contact_email.nil? ? "<a href='mailto:#{record.contact_email}?Subject=Hello%20#{record.poc_name.nil? ? '' :  record.poc_name.capitalize}' target='_top'>#{record.contact_email.downcase}&nbsp;<i class='far fa-envelope'></i></a>".html_safe : "",
        approved: record.approved ? "<b class='text-success'>Y</b>".html_safe : "<i class='text-danger'>N</i>".html_safe,
        complete_record: record.complete_record ? "<b class='text-success'>Y</b>".html_safe : "<i class='text-danger'>N</i>".html_safe,
        date_opened: record.c_activity_date_opened.nil? ? "" : record.c_activity_date_opened.strftime('%m/%d/%Y').to_s,
        three_weeks_lapse: record.three_weeks_lapse

      }
    end
  end

  def get_raw_records
    # insert query here
    Carrier.listings
  end

  def is_numeric?(obj)
   obj.to_s.match(/\A[+-]?\d+?(\.\d+)?\Z/) == nil ? false : true
  end

  def filter_on_id
    ->(column, value) {
      if is_numeric?(column.search.value)
        ::Arel::Nodes::SqlLiteral.new("carriers.id").eq(column.search.value)
      else
        search_value = URI.unescape(column.search.value)
        ::Arel::Nodes::SqlLiteral.new("CAST(carriers.#{column.field.to_s} AS VARCHAR)").matches("%#{search_value}%")
      end
    }
  end

  def filter_on_string
    ->(column, value) {
      search_value = URI.unescape(column.search.value)
      ::Arel::Nodes::SqlLiteral.new("CAST(carriers.#{column.field.to_s} AS VARCHAR)").matches("%#{search_value}%")
    }
  end

  def filter_on_boolean
    ->(column, value) {
      if is_numeric?(column.search.value) && column.search.value.to_i < 2
        ::Arel::Nodes::SqlLiteral.new("carriers.#{column.field.to_s}").eq(column.search.value)
      else
        search_value = URI.unescape(column.search.value)
        ::Arel::Nodes::SqlLiteral.new("CAST(carriers.#{column.field.to_s} AS VARCHAR)").matches("%#{search_value}%")
      end
    }
  end


  def filter_on_date
    ->(column, value) {
      date_value = column.search.value.tr('/', '-')
      search_value = URI.unescape(date_value)
      ::Arel::Nodes::SqlLiteral.new("CAST(carriers.#{column.field.to_s} AS VARCHAR)").matches("%#{
          search_value}%")
    }
  end

  def filter_on_range_teams
    ->(column, value) {
      data_values = column.search.value.split("-yadcf_delim-")
      ::Arel::Nodes::Between.new(
          Arel.sql(column.field.to_s),
          Arel::Nodes::And.new(
            [
              data_values[0] ? data_values[0].to_i : 0,
              data_values[1] ? data_values[1].to_i : 99999
            ]
          )
        )

    }
  end

  def filter_on_range
    ->(column, value) {
      data_values = column.search.value.split("-yadcf_delim-")
      column_name = "carriers.#{column.field.to_s}"
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
        ::Arel::Nodes::SqlLiteral.new("CAST(carriers.#{column.field.to_s} AS VARCHAR)").matches("%#{search_value}%")
      end
    }
  end

  def filter_on_numbers
    ->(column, value) {
      search_value = URI.unescape(column.search.value)
      if is_numeric?(column.search.value)
        ::Arel::Nodes::SqlLiteral.new("carriers.#{column.field.to_s}").eq(search_value)
      else
        ::Arel::Nodes::SqlLiteral.new("CAST(carriers.#{column.field.to_s} AS VARCHAR)").matches("%#{search_value}%")
      end
      # if (column.search.value && column.search.value != 0 && column.search.value !=  "0")
      #   "carriers.#{column.field.to_s.gsub("current_", "")} <> 0 AND carriers.#{column.field.to_s.gsub("current_", "")} = #{column.search.value}"
      # else
      #   "carriers.#{column.field.to_s.gsub("current_", "")} = #{column.search.value}"
      # end
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
                               Arel::Nodes::SqlLiteral.new("carriers.c_lane_origin").matches("%#{dc.strip}%"),
                               Arel::Nodes::SqlLiteral.new("carriers.c_lane_destination").matches("%#{dc.strip}%")
                             )
             else
               data_value_0_sql_script = Arel::Nodes::Or.new(
                               data_value_0_sql_script,
                               Arel::Nodes::Or.new(
                                               Arel::Nodes::SqlLiteral.new("carriers.c_lane_origin").matches("%#{dc.strip}%"),
                                               Arel::Nodes::SqlLiteral.new("carriers.c_lane_destination").matches("%#{dc.strip}%")
                                             )
                             )
             end
           end
         else
           data_value_0_sql_script =   Arel::Nodes::Or.new(
                             Arel::Nodes::SqlLiteral.new("carriers.c_lane_origin").matches("%#{data_values[0].strip}%"),
                             Arel::Nodes::SqlLiteral.new("carriers.c_lane_destination").matches("%#{data_values[0].strip}%")
                           )
         end
         if data_column_1.length > 1
           data_column_1.each do |dc|
             if data_value_1_sql_script.nil?
               data_value_1_sql_script = Arel::Nodes::Or.new(
                               Arel::Nodes::SqlLiteral.new("carriers.c_lane_origin").matches("%#{dc.strip}%"),
                               Arel::Nodes::SqlLiteral.new("carriers.c_lane_destination").matches("%#{dc.strip}%")
                             )
             else
               data_value_1_sql_script = Arel::Nodes::Or.new(
                               data_value_1_sql_script,
                               Arel::Nodes::Or.new(
                                               Arel::Nodes::SqlLiteral.new("carriers.c_lane_origin").matches("%#{dc.strip}%"),
                                               Arel::Nodes::SqlLiteral.new("carriers.c_lane_destination").matches("%#{dc.strip}%")
                                             )
                             )
             end
           end
         else
           data_value_1_sql_script =   Arel::Nodes::Or.new(
                             Arel::Nodes::SqlLiteral.new("carriers.c_lane_origin").matches("%#{data_values[1].strip}%"),
                             Arel::Nodes::SqlLiteral.new("carriers.c_lane_destination").matches("%#{data_values[1].strip}%")
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
                              Arel::Nodes::SqlLiteral.new("carriers.c_lane_origin").matches("%#{dc.strip}%"),
                              Arel::Nodes::SqlLiteral.new("carriers.c_lane_destination").matches("%#{dc.strip}%")
                            )
            else
              data_value_0_sql_script = Arel::Nodes::Or.new(
                              data_value_0_sql_script,
                              Arel::Nodes::Or.new(
                                              Arel::Nodes::SqlLiteral.new("carriers.c_lane_origin").matches("%#{dc.strip}%"),
                                              Arel::Nodes::SqlLiteral.new("carriers.c_lane_destination").matches("%#{dc.strip}%")
                                            )
                            )
            end
          end
        else
          data_value_0_sql_script =   Arel::Nodes::Or.new(
                            Arel::Nodes::SqlLiteral.new("carriers.c_lane_origin").matches("%#{data_values[0].strip}%"),
                            Arel::Nodes::SqlLiteral.new("carriers.c_lane_destination").matches("%#{data_values[0].strip}%")
                          )
        end
        ::Arel::Nodes::Grouping.new(
          data_value_0_sql_script
        )
      end
    }
  end

  def filter_on_primary_phone
    ->(column, value) {
      search_value = URI.unescape(column.search.value)
      ::Arel::Nodes::SqlLiteral.new("contacts.primary_phone").matches("%#{search_value}%")
    }
  end

  def filter_on_contact_email
    ->(column, value) {
      search_value = URI.unescape(column.search.value)
      ::Arel::Nodes::SqlLiteral.new("contacts.email").matches("%#{search_value}%")
    }
  end

  def filter_on_date_opened
    ->(column, value) {
      date_opened = column.search.value.tr('/', '-')
      search_value = URI.unescape(date_opened)
      ::Arel::Nodes::SqlLiteral.new("CAST(carriers.#{column.field.to_s} AS VARCHAR)").matches("%#{
        search_value}%")
    }
  end

  def filter_on_approved
    ->(column, value) {
      if is_numeric?(column.search.value)
        ::Arel::Nodes::SqlLiteral.new("carriers.approved").eq(column.search.value)
      else
        search_value = URI.unescape(column.search.value)
        ::Arel::Nodes::SqlLiteral.new("CAST(carriers.#{column.field.to_s} AS VARCHAR)").matches("%#{search_value}%")
      end
    }
  end

  def filter_on_complete_record
    ->(column, value) {
      if is_numeric?(column.search.value)
        ::Arel::Nodes::SqlLiteral.new("carriers.complete_record").eq(column.search.value)
      else
        search_value = URI.unescape(column.search.value)
        ::Arel::Nodes::SqlLiteral.new("CAST(carriers.#{column.field.to_s} AS VARCHAR)").matches("%#{search_value}%")
      end
    }

  end

  def filter_on_blacklisted
    ->(column, value) {
      if is_numeric?(column.search.value)
        ::Arel::Nodes::SqlLiteral.new("carriers.blacklisted").eq(column.search.value)
      else
        search_value = URI.unescape(column.search.value)
        ::Arel::Nodes::SqlLiteral.new("CAST(carriers.#{column.field.to_s} AS VARCHAR)").matches("%#{search_value}%")
      end
    }
  end

  def filter_on_poc_name
    ->(column, value) {
      search_value = URI.unescape(column.search.value)
      ::Arel::Nodes::SqlLiteral.new("CONCAT(contacts.first_name, ' ', contacts.last_name)").matches("%#{search_value}%")
     }
  end

  def filter_on_tier
    ->(column, value) {
      if column.search.value == "None"
        "COALESCE(carriers.c_mc_latest_date_tier,carriers.c_carr_tier_tier) = '' OR COALESCE(carriers.c_mc_latest_date_tier,carriers.c_carr_tier_tier) = 'None' OR COALESCE(carriers.c_mc_latest_date_tier,carriers.c_carr_tier_tier) = 'none' OR COALESCE(carriers.c_mc_latest_date_tier,carriers.c_carr_tier_tier) = 'NONE' OR COALESCE(carriers.c_mc_latest_date_tier,carriers.c_carr_tier_tier) = 'N/A' OR COALESCE(carriers.c_mc_latest_date_tier,carriers.c_carr_tier_tier) = 'NA' OR COALESCE(carriers.c_mc_latest_date_tier,carriers.c_carr_tier_tier) IS NULL"
      else
        search_value = URI.unescape(column.search.value)
        ::Arel::Nodes::SqlLiteral.new("COALESCE(carriers.c_mc_latest_date_tier,carriers.c_carr_tier_tier)").matches("%#{search_value}%")
      end
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
        :reefers_sum => reefers_sum,
        :teams_sum => teams_sum,
        :loads_lws_sum => loads_lws_sum,
        :one_m_sum => one_m_sum,
        :six_m_sum => six_m_sum,
        :data => data

      }
  end

  def reefers_sum
    records.sum(:reefers)
  end

  def teams_sum
    records.sum(:teams)
  end

  def loads_lws_sum
    records.sum(:c_carr_new_loads_lw)
  end

  def one_m_sum
    records.sum(:c_mc_latest_date_last_month)
  end

  def six_m_sum
    records.sum(:c_mc_latest_date_last_6_months)
  end

end
