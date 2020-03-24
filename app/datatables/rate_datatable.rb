class RateDatatable < AjaxDatatablesRails::ActiveRecord
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
      id: { source: "Rate.id" },
      origin_city: { source: "Rate.origin_city" },
      origin_state: { source: "Rate.origin_state" },
      destination_city: { source: "Rate.destination_city" },
      destination_state: { source: "Rate.destination_state" },
      miles: { source: "Rate.miles" },
      rate_type: { source: "Rate.rate_type" },
      picks: { source: "Rate.picks" },
      drops: { source: "Rate.drops" },
      team: { source: "Rate.team" },
      commodities: { source: "Rate.commodities" },
      bid: { source: "Rate.bid" },
      ask: { source: "Rate.ask" },
      accepted: { source: "Rate.accepted" },
      cost: { source: "Rate.cost" },
      money_currency: { source: "Rate.money_currency" },
      mc_number: { source: "Rate.mc_number" },
      notes: { source: "Rate.notes" },
      created_at: { source: "Rate.created_at" },
      carrier_id: { source: "Rate.carrier_id" },
      shipper_id: { source: "Rate.shipper_id" }
    }
  end

  def data
    records.map do |record|
      {
        actions: record.decorate.dt_actions,
        id: record.id,
        origin_city: record.origin_city,
        origin_state: generate_abv(record.origin_state).upcase,
        destination_city: record.destination_city,
        destination_state: generate_abv(record.destination_state).upcase,
        miles: record.miles,
        rate_type: record.rate_type,
        picks: record.picks,
        drops: record.drops,
        team: (record.team == "Yes") ? "<b class='text-success>#{record.team}</b>".html_safe : "<b class='text-danger>#{record.team}</b>".html_safe,
        commodities: record.decorate.commodities,
        bid: record.bid,
        ask: record.ask,
        accepted: record.accepted ? "<b class='text-success'>Yes</b>".html_safe : "<i class='text-danger'>No</i>".html_safe,
        cost: record.cost,
        money_currency: record.money_currency,
        mc_number: record.mc_number,
        notes: record.decorate.notes,
        created_at: record.created_at,
        carrier_id: record.decorate.link_to_carrier,
        shipper_id: record.decorate.link_to_shipper
      }
    end
  end

  def get_raw_records
    # insert query here
    Rate.all
  end

end
