class CarrierDatatable < AjaxDatatablesRails::ActiveRecord
  include ApplicationHelper
  include ActionView::Helpers::NumberHelper
  extend Forwardable

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
      id: { source: "Carrier.id" },
      c_reminder_date: { source: "Carrier.c_reminder_date" },
      interview: { source: "Carrier.interview", cond: :eq },
      wolfbyte: { source: "Carrier.wolfbyte", cond: :eq },
      relationship_owner_name: { source: "Carrier.relationship_owner_name" },
      sales_priority: { source: "Carrier.sales_priority" },
      mc_number: { source: "Carrier.mc_number" },
      company_name: { source: "Carrier.company_name" },
      power_units: { source: "Carrier.power_units" },
      reefers: { source: "Carrier.reefers" },
      teams: { source: "Carrier.teams" },
      c_mc_latest_date_load_days: { source: "Carrier.c_mc_latest_date_load_days" },
      c_mc_latest_date_tier: { source: "Carrier.c_mc_latest_date_tier, Carrier.c_carr_tier_tier" },
      loads_lw: { source: "Carrier.loads_lw" },
      c_mc_latest_date_last_month: { source: "Carrier.c_mc_latest_date_last_month" },
      c_mc_latest_date_last_6_months: { source: "Carrier.c_mc_latest_date_last_6_months" },
      c_lane_origin: { source: "Carrier.c_lane_origin, Carrier.c_lane_destination" },
      c_lane_destination: { source: "Carrier.c_lane_destination" },
      blacklisted: { source: "Carrier.blacklisted" },
      poc_name: {source: "poc_name"},
      primary_phone: { source: "Carrier.primary_phone" },
      contact_email: {source: "contact_email"},
      approved: { source: "Carrier.approved" },
      complete_record: { source: "Carrier.complete_record" },
      date_opened: { source: "Carrier.date_opened" }
    }
  end

  def data
    records.map do |record|
      {
        id: check_box_tag('carriers[]', record.id),
        c_reminder_date: record.c_reminder_date ? format_reminder(record.c_reminder_date, record.c_reminder_type, record.c_reminder_notes).html_safe : "",
        interview: record.interview ? "<i class='text-success'>Yes</i>".html_safe : "<i class='text-danger'>No</i>".html_safe,
        wolfbyte: record.wolfbyte ? "<i class='text-success'>Yes</i>".html_safe : "<i class='text-danger'>No</i>".html_safe,
        relationship_owner_name: record.relationship_owner_name ? (record['relationship_owner_name'].blank? ? '(no name)' : "#{link_to(covert_initials(record['relationship_owner_name']), user_path(:id => record['relationship_owner']))}".html_safe) : '',
        sales_priority: shade_sales_priority(record.sales_priority).html_safe,
        mc_number: record.decorate.mc_number,
        company_name: record.decorate.link_to,
        power_units: record.power_units && record.power_units > 0 ? record.power_units : "",
        reefers: record.reefers && record.reefers > 0 ? record.reefers : "",
        teams: record.teams && record.teams > 0 ? record.teams : "",
        c_mc_latest_date_load_days: record.c_mc_latest_date_load_days && record.c_mc_latest_date_load_days > 0 ? record.c_mc_latest_date_load_days : "",
        c_mc_latest_date_tier: record.c_mc_latest_date_tier ? generate_rank_text(record.c_mc_latest_date_tier).html_safe : (record.c_carr_tier_tier ? generate_rank_text(record.c_carr_tier_tier).html_safe : "No Tier Yet"),
        loads_lw: record.loads_lw,
        c_mc_latest_date_last_month: record.c_mc_latest_date_last_month && record.c_mc_latest_date_last_month > 0 ? record.c_mc_latest_date_last_month : "",
        c_mc_latest_date_last_6_months: record.c_mc_latest_date_last_6_months && record.c_mc_latest_date_last_6_months > 0 ? record.c_mc_latest_date_last_6_months : "",
        c_lane_origin: record.decorate.lanes,
        blacklisted: record.blacklisted ? "<i class='text-danger'>Yes</i>".html_safe : "<i class='text-success'>No</i>".html_safe,
        poc_name: record.poc_name,
        primary_phone: record.primary_phone.nil? ? '' : generate_phone_number("", record.primary_phone, record.primary_extension_number, record.primary_eligible_texting, record.primary_phone_type).html_safe,
        contact_email: !record.contact_email.nil? ? "<a href='mailto:#{record.contact_email}?Subject=Hello%20#{record.poc_name.nil? ? '' :  record.poc_name.capitalize}' target='_top'>#{record.contact_email.downcase}&nbsp;<i class='far fa-envelope'></i></a>".html_safe : "",
        approved: record.approved ? "<b class='text-success'>Y</b>".html_safe : "<i class='text-danger'>N</i>".html_safe,
        complete_record: record.complete_record ? "<b class='text-success'>Y</b>".html_safe : "<i class='text-danger'>N</i>".html_safe,
        date_opened: record.date_opened.nil? ? "" : record.date_opened.strftime('%m/%d/%Y').to_s,
        three_weeks_lapse: record.three_weeks_lapse

      }
    end
  end

  def get_raw_records
    # insert query here
    Carrier.all
  end

end
