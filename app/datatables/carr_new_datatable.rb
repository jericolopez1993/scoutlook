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
      interview: { source: "Carrier.interview", cond: filter_for_boolean_carriers },
      wolfbyte: { source: "Carrier.wolfbyte", cond: filter_for_boolean_carriers },
      sales_priority: { source: "Carrier.sales_priority", cond: filter_on_string_carriers },
      relationship_owner: { source: "relationship_owner_name", cond: filter_for_relationship_owner_initials },
      mc_number: { source: "SlCarrNew.mc_number", cond: filter_on_string },
      carrier_name: { source: "SlCarrNew.carrier_name", cond: filter_on_string },
      power_units: { source: "Carrier.power_units", cond: filter_on_numbers_carriers },
      reefers: { source: "Carrier.reefers", cond: filter_on_numbers_carriers },
      teams: { source: "Carrier.teams", cond: filter_on_numbers_carriers },
      contact: { source: "SlCarrNew.contact", cond: filter_on_string },
      last_os: { source: "SlCarrNew.last_os", cond: filter_on_string },
      last_ds: { source: "SlCarrNew.last_ds", cond: filter_on_string },
      wk: { source: "wk", cond: filter_for_wk },
      first_load_date: { source: "SlCarrNew.first_load_date", cond: filter_on_date },
      gross_margin: { source: "SlCarrNew.gross_margin", cond: filter_on_numbers },
      loads_lw: { source: "SlCarrNew.loads_lw", cond: filter_on_numbers },
      loads_2w: { source: "SlCarrNew.loads_2w", cond: filter_on_numbers },
      loads_3w: { source: "SlCarrNew.loads_3w", cond: filter_on_numbers },
      loads_4w: { source: "SlCarrNew.loads_4w", cond: filter_on_numbers },
      loads_5w: { source: "SlCarrNew.loads_5w", cond: filter_on_numbers },
      loads_6w: { source: "SlCarrNew.loads_6w", cond: filter_on_numbers },
      current_tier: { source: "CarrTier.tier", cond: filter_for_tier }
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
        carrier_name: record['carrier_id'] ? record.decorate.truncate_link_to : record.decorate.truncate_carrier_name,
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
    SlCarrNew.listings
  end

  def filter_for_wk
    ->(column, value) { ::Arel::Nodes::SqlLiteral.new("CAST(TO_CHAR(NOW() - carr_new.first_load_date, 'W') AS INTEGER)").eq(column.search.value.to_i) }
  end

  def filter_for_tier
    ->(column, value) { ::Arel::Nodes::SqlLiteral.new("carr_tier.tier").matches("%#{column.search.value}%") }
  end

  def filter_for_boolean_carriers
    ->(column, value) {
      if is_numeric?(column.search.value) && column.search.value.to_i < 2
        ::Arel::Nodes::SqlLiteral.new("carriers.#{column.field.to_s}").eq(column.search.value)
      else
        search_value = URI.unescape(column.search.value)
        ::Arel::Nodes::SqlLiteral.new("CAST(carriers.#{column.field.to_s} AS VARCHAR)").matches("%#{search_value}%")
      end
    }
  end

  def filter_for_relationship_owner_initials
    ->(column, value) { ::Arel::Nodes::SqlLiteral.new("CONCAT(SUBSTR(relationship_owner_user.first_name, 1, 1), SUBSTR(relationship_owner_user.last_name, 1, 1))").matches("%#{column.search.value}%") }
  end

  def is_numeric?(obj)
   obj.to_s.match(/\A[+-]?\d+?(\.\d+)?\Z/) == nil ? false : true
  end

  def filter_on_id
    ->(column, value) {
      if is_numeric?(column.search.value)
        ::Arel::Nodes::SqlLiteral.new("carr_new.id").eq(column.search.value)
      else
        search_value = URI.unescape(column.search.value)
        ::Arel::Nodes::SqlLiteral.new("CAST(carr_new.#{column.field.to_s} AS VARCHAR)").matches("%#{search_value}%")
      end
    }
  end

  def filter_on_string
    ->(column, value) {
      search_value = URI.unescape(column.search.value)
      ::Arel::Nodes::SqlLiteral.new("CAST(carr_new.#{column.field.to_s} AS VARCHAR)").matches("%#{search_value}%")
    }
  end

  def filter_on_string_carriers
    ->(column, value) {
      search_value = URI.unescape(column.search.value)
      ::Arel::Nodes::SqlLiteral.new("CAST(carriers.#{column.field.to_s} AS VARCHAR)").matches("%#{search_value}%")
    }
  end

  def filter_on_boolean
    ->(column, value) {
      if is_numeric?(column.search.value) && column.search.value.to_i < 2
        ::Arel::Nodes::SqlLiteral.new("carr_new.#{column.field.to_s}").eq(column.search.value)
      else
        search_value = URI.unescape(column.search.value)
        ::Arel::Nodes::SqlLiteral.new("CAST(carr_new.#{column.field.to_s} AS VARCHAR)").matches("%#{search_value}%")
      end
    }
  end


  def filter_on_date
    ->(column, value) {
      date_value = column.search.value.tr('/', '-')
      search_value = URI.unescape(date_value)
      ::Arel::Nodes::SqlLiteral.new("CAST(carr_new.#{column.field.to_s} AS VARCHAR)").matches("%#{
          search_value}%")
    }
  end

  def filter_on_range
    ->(column, value) {
      data_values = column.search.value.split("-yadcf_delim-")
      column_name = "carr_new.#{column.field.to_s}"
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
        ::Arel::Nodes::SqlLiteral.new("CAST(carr_new.#{column.field.to_s} AS VARCHAR)").matches("%#{search_value}%")
      end
    }
  end

  def filter_on_numbers
    ->(column, value) {
      search_value = URI.unescape(column.search.value)
      if is_numeric?(column.search.value)
        ::Arel::Nodes::SqlLiteral.new("carr_new.#{column.field.to_s}").eq(search_value)
      else
        ::Arel::Nodes::SqlLiteral.new("CAST(carr_new.#{column.field.to_s} AS VARCHAR)").matches("%#{search_value}%")
      end
    }
  end

  def filter_on_numbers_carriers
    ->(column, value) {
      search_value = URI.unescape(column.search.value)
      if is_numeric?(column.search.value)
        ::Arel::Nodes::SqlLiteral.new("carriers.#{column.field.to_s}").eq(search_value)
      else
        ::Arel::Nodes::SqlLiteral.new("CAST(carriers.#{column.field.to_s} AS VARCHAR)").matches("%#{search_value}%")
      end
    }
  end


end
