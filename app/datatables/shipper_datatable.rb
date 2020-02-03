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
      id: { source: "Shipper.id" },
      c_reminder_date: { source: "Shipper.c_reminder_date" },
      relationship_owner_name: { source: "Shipper.relationship_owner" },
      sales_priority: { source: "Shipper.sales_priority" },
      company_name: { source: "Shipper.company_name" },
      state: { source: "state" },
      pdm_name: { source: "pdm_name" },
      primary_phone: { source: "primary_phone" },
      c_lane_origin: { source: "Shipper.c_lane_origin" },
      contact_email: { source: "contact_email" },
      approved: { source: "Shipper.approved" },
      complete_record: { source: "Shipper.complete_record" },
      date_opened: { source: "Shipper.date_opened" },
      load_last_month: { source: "Shipper.load_last_month" },
      load_last_6_month: { source: "Shipper.load_last_6_month" },
      city: { source: "city" },
      loads_per_month: { source: "Shipper.loads_per_month" },
      commodities: { source: "Shipper.commodities" },
    }
  end

  def data
    records.map do |record|
      {
        id: check_box_tag('shippers[]', record.id),
        c_reminder_date: record.c_reminder_date ? format_reminder(record.c_reminder_id, record.c_reminder_date, record.c_reminder_type, record.c_reminder_notes).html_safe : "",
        relationship_owner_name: record.relationship_owner_name ? (record['relationship_owner_name'].blank? ? '(no name)' : "#{link_to(covert_initials(record['relationship_owner_name']), user_path(:id => record['relationship_owner']))}".html_safe) : '',
        sales_priority: shade_sales_priority(record.sales_priority).html_safe,
        company_name: record.decorate.link_to,
        state: record.state,
        pdm_name: record.pdm_name,
        primary_phone: record.primary_phone.nil? ? '' : generate_phone_number("", record.primary_phone, record.primary_extension_number, record.primary_eligible_texting, record.primary_phone_type).html_safe,
        c_lane_origin: record.decorate.lanes,
        contact_email: !record.contact_email.nil? ? "<a href='mailto:#{record.contact_email}?Subject=Hello%20#{record.pdm_name.nil? ? '' :  record.pdm_name.capitalize}' target='_top'>#{record.contact_email.downcase}&nbsp;<i class='far fa-envelope'></i></a>".html_safe : "",
        approved: record.approved ? "<b class='text-success'>Y</b>".html_safe : "<i class='text-danger'>N</i>".html_safe,
        complete_record: record.complete_record ? "<b class='text-success'>Y</b>".html_safe : "<i class='text-danger'>N</i>".html_safe,
        date_opened: record.date_opened.nil? ? "" : record.date_opened.strftime('%m/%d/%Y').to_s,
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

end
