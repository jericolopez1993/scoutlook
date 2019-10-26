class DfLoadDatatable < AjaxDatatablesRails::ActiveRecord
  extend Forwardable

  def_delegator :@view, :link_to
  def_delegator :@view, :carrier_path

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
      load_number: { source: "DfLoad.load_num" },
      ship_date: { source: "DfLoad.ship_date" },
      customer: { source: "DfLoad.customer" },
      origin: { source: "DfLoad.origin" },
      os: { source: "DfLoad.os" },
      destination: { source: "DfLoad.destination" },
      ds: { source: "DfLoad.ds" },
      mc_number: { source: "DfLoad.mc_num" },
      carrier: { source: "DfLoad.carrier" },
      curr: { source: "DfLoad.curr" },
      ttt: { source: "DfLoad.ttt" },
      billing: { source: "DfLoad.billing" },
      gm: { source: "DfLoad.gm" },
      gmper: { source: "DfLoad.gmper" },
      cust_sys: { source: "DfLoad.cust_sys" },
      carr_sys: { source: "DfLoad.carr_sys" },
      gross_margin: { source: "DfLoad.gross_margin" },
      exchange_rate: { source: "DfLoad.exchange_rate" },
      sales: { source: "DfLoad.sales" },
      dispatch: { source: "DfLoad.dispatch" },
      truck: { source: "DfLoad.truck" }
    }
  end
  def data
    records.map do |record|
      {
        load_number: link_to(record.load_num, controller: "loads", action: "show", id: record.load_num),
        ship_date: record.ship_date.to_date,
        customer: record.customer,
        origin: record.origin,
        os: record.os,
        destination: record.destination,
        ds: record.ds,
        mc_number: record.mc_num,
        carrier: record['carrier_id'] ? link_to(record.carrier, controller: "carriers", action: "show", id: record['carrier_id']) : record.carrier,
        curr: record.curr.to_f.round,
        ttt: record.ttt.to_f.round,
        billing: record.billing.to_f.round,
        gm: record.gm.to_f.round,
        gmper: record.gmper + '%',
        cust_sys: record.cust_sys.to_f.round,
        carr_sys: record.carr_sys.to_f.round,
        gross_margin: record.gross_margin.to_f.round,
        exchange_rate: record.exchange_rate,
        sales: record.sales,
        dispatch: record.dispatch,
        truck: record.truck
        # example:
        # id: record.id,
        # name: record.name
      }
    end
  end

  def get_raw_records
    # insert query here
    DfLoad.all
  end

end
