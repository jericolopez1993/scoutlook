class CarrPromDatatable < AjaxDatatablesRails::ActiveRecord
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
      mc_number: { source: "CarrProm.mc_number" },
      carrier_name: { source: "CarrProm.carrier_name" },
      current_tier: { source: "CarrProm.current_tier" },
      previous_tier: { source: "CarrProm.previous_tier" },
      highest_tier: { source: "CarrProm.highest_tier" },
      highest_tier_date: { source: "CarrProm.highest_tier_date" },
      gross_margin: { source: "CarrProm.gross_margin" },
      load_last_week: { source: "CarrProm.load_last_week" },
      load_last_month: { source: "CarrProm.load_last_month" },
      load_last_3_months: { source: "CarrProm.load_last_3_months" },
      load_last_6_months: { source: "CarrProm.load_last_6_months" },
      highest_tier_reached: { source: "CarrProm.highest_tier_reached" },
      primary_phone: { source: "CarrProm.primary_phone" },
      secondary_phone: { source: "CarrProm.secondary_phone" },
      sales_priority: { source: "CarrProm.sales_priority" },
      relationship_owner_name: { source: "relationship_owner_name" }
    }
  end

  def data
    records.map do |record|
      {
        mc_number: record.mc_number,
        carrier_name: record['carrier_id'] ? record.decorate.link_to : record.carrier_name,
        current_tier: generate_rank_text(record['current_tier']).html_safe,
        previous_tier: generate_rank_text(record['previous_tier']).html_safe,
        highest_tier: generate_rank_text(record['highest_tier']).html_safe,
        highest_tier_date: record['highest_tier_date'] ? DateTime.parse(record['highest_tier_date']).strftime('%m/%d/%Y') : "",
        gross_margin: record.gross_margin,
        load_last_week: record.load_last_week && record.load_last_week > 0 ? number_with_precision(record.load_last_week, strip_insignificant_zeros: true, precision: 2) : "",
        load_last_month: record.load_last_month && record.load_last_month > 0 ? number_with_precision(record.load_last_month, strip_insignificant_zeros: true, precision: 2) : "",
        load_last_3_months: record.load_last_3_months && record.load_last_3_months > 0 ? number_with_precision(record.load_last_3_months, strip_insignificant_zeros: true, precision: 2) : "",
        load_last_6_months: record.load_last_6_months && record.load_last_6_months > 0 ? number_with_precision(record.load_last_6_months, strip_insignificant_zeros: true, precision: 2) : "",
        highest_tier_reached: record.highest_tier_reached,
        primary_phone: record.primary_phone,
        secondary_phone: record.secondary_phone,
        sales_priority: record.sales_priority ? shade_sales_priority(record.sales_priority).html_safe : '',
        relationship_owner: record.user_id ? (record['relationship_owner_name'].blank? ? '(no name)' : "#{link_to(covert_initials(record['relationship_owner_name']), user_path(:id => record['user_id']))}".html_safe) : ''
        # example:
        # id: record.id,
        # name: record.name
      }
    end
  end

  def get_raw_records
    # insert query here
    CarrProm.all
  end

end
