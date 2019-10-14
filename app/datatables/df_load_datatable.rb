class DfLoadDatatable < AjaxDatatablesRails::ActiveRecord

  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format
    @view_columns ||= {
      # id: { source: "User.id", cond: :eq },
      # name: { source: "User.name", cond: :like }
      load_number: { source: '"Load_Num"' },
      ship_date: { source: '"Ship_Date"' },
      customer: { source: '"Customer"' },
      origin: { source: '"Origin"' },
      os: { source: '"OS"' },
      destination: { source: '"Destination"' },
      ds: { source: '"DS"' },
      mc_number: { source: '"MC_Num"' },
      carrier: { source: '"Carrier"' },
      curr: { source: '"Curr"' },
      ttt: { source: '"TTT"' },
      billing: { source: '"Billing"' },
      gm: { source: '"GM"' },
      gmper: { source: '"GMPER"' },
      cust_sys: { source: '"Cust_Sys"' },
      carr_sys: { source: '"Carr_Sys"' },
      gross_margin: { source: '"Gross_Margin"' },
      exchange_rate: { source: '"Exchange_Rate"' },
      sales: { source: '"Sales"' },
      dispatch: { source: '"Dispatch"' },
      truck: { source: '"Truck"' }
    }
  end
  def data
    records.map do |record|
      {
        load_number: record['Load_Num'],
        ship_date: record['Ship_Date'],
        customer: record['Customer'],
        origin: record['Origin'],
        os: record['OS'],
        destination: record['Destination'],
        ds: record['DS'],
        mc_number: record['MC_Num'],
        carrier: record['Carrier'],
        curr: record['Curr'],
        ttt: record['TTT'],
        billing: record['Billing'],
        gm: record['GM'],
        gmper: record['GMPER'],
        cust_sys: record['Cust_Sys'],
        carr_sys: record['Carr_Sys'],
        gross_margin: record['Gross_Margin'],
        exchange_rate: record['Exchange_Rate'],
        sales: record['Sales'],
        dispatch: record['Dispatch'],
        truck: record['Truck']
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
