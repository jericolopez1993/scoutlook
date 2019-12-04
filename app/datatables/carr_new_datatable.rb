class CarrNewDatatable < AjaxDatatablesRails::ActiveRecord
  include ApplicationHelper
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
      # id: { source: "User.id", cond: :eq },
      # name: { source: "User.name", cond: :like }
      interview: { source: "Carrier.interview", cond: :eq, },
      wolfbyte: { source: "Carrier.wolfbyte", cond: :eq },
      sales_priority: { source: "CarrNew.sales_priority" },
      relationship_owner: { source: "relationship_owner_name" },
      mc_number: { source: "CarrNew.mc_number" },
      carrier_name: { source: "CarrNew.carrier_name" },
      power_units: { source: "CarrNew.power_units" },
      reefers: { source: "CarrNew.reefers" },
      teams: { source: "CarrNew.teams" },
      contact: { source: "CarrNew.contact" },
      last_os: { source: "CarrNew.last_os" },
      last_ds: { source: "CarrNew.last_ds" },
      wk: { source: "wk" },
      first_load_date: { source: "CarrNew.first_load_date" },
      gross_margin: { source: "CarrNew.gross_margin" },
      loads_lw: { source: "CarrNew.loads_lw" },
      loads_2w: { source: "CarrNew.loads_2w" },
      loads_3w: { source: "CarrNew.loads_3w" },
      loads_4w: { source: "CarrNew.loads_4w" },
      loads_5w: { source: "CarrNew.loads_5w" },
      loads_6w: { source: "CarrNew.loads_6w" },
      current_tier: { source: "CarrTier.tier" }
    }
  end

  def data
    records.map do |record|
      {
        interview: record.interview  ? "<i class='text-success'>Yes</i>".html_safe : "<i class='text-danger'>No</i>".html_safe,
        wolfbyte: record.wolfbyte  ? "<i class='text-success'>Yes</i>".html_safe : "<i class='text-danger'>No</i>".html_safe,
        sales_priority: record.sales_priority ? shade_sales_priority(record.sales_priority).html_safe : '',
        relationship_owner: record.user_id ? (record['relationship_owner_name'].blank? ? '(no name)' : "#{link_to(covert_initials(record['relationship_owner_name']), user_path(:id => record['user_id']))}".html_safe) : '',
        mc_number: record.mc_number,
        carrier_name: record['carrier_id'] ? record.decorate.link_to : record.carrier,
        power_units: (record.power_units && record.power_units > 0) ? record.power_units : "",
        reefers: (record.reefers && record.reefers > 0) ? record.reefers : "",
        teams: (record.teams && record.teams > 0) ? record.teams : "",
        contact: record.contact,
        last_os: record.last_os,
        last_ds: record.last_ds,
        wk: record.wk.to_i,
        first_load_date:  record.first_load_date ? record.first_load_date.strftime('%m/%d/%Y') : "",
        gross_margin: record.gross_margin,
        loads_lw: record.loads_lw,
        loads_2w: record.loads_2w,
        loads_3w: record.loads_3w,
        loads_4w: record.loads_4w,
        loads_5w: record.loads_5w,
        loads_6w: record.loads_6w,
        current_tier: generate_rank_text(record['tier']).html_safe
        # example:
        # id: record.id,
        # name: record.name
      }
    end
  end

  def get_raw_records
    # insert query here
    CarrNew.all
  end

end
