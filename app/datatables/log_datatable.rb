class LogDatatable < AjaxDatatablesRails::ActiveRecord
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
      user_name: { source: "user_name", cond: filter_on_user_name },
      created_at: { source: "created_at", cond: filter_on_date },
      auditable_type: { source: "description", cond: filter_on_string },
      user_id: { source: "user_id" },
    }
  end

  def data
    records.map do |record|
      {
        user_name: record.user_name,
        created_at: record.created_at.strftime('%m/%d/%Y %l:%M %p'),
        auditable_type: record.description.html_safe,
        user_id: record.user_id ? (record.user_name.blank? ? '(no name)' : "#{link_to(record.user_name, user_path(:id => record.user_id))}".html_safe) : ''
        # example:
        # id: record.id,
        # name: record.name
      }
    end
  end

  def get_raw_records
    # insert query here
    Log.overall
  end

  def user
    @user ||= options[:user]
  end

  def as_json(options = {})
      {
        :draw => params[:draw].to_i,
        :recordsTotal =>  get_raw_records.length,
        :recordsFiltered => filter_records(get_raw_records).length,
        :data => data

      }
  end

  def filter_on_user_name
    ->(column, value) {
      search_value = URI.unescape(column.search.value)
      ::Arel::Nodes::SqlLiteral.new("CONCAT(users.first_name, ' ', users.last_name)").matches("%#{search_value}%")
    }
  end

  def filter_on_string
    ->(column, value) {
      search_value = URI.unescape(column.search.value)
      ::Arel::Nodes::SqlLiteral.new("CAST(logs.#{column.field.to_s} AS VARCHAR)").matches("%#{search_value}%")
    }
  end

    def filter_on_date
      ->(column, value) {
        date_value = column.search.value.tr('/', '-')
        search_value = URI.unescape(date_value)
        ::Arel::Nodes::SqlLiteral.new("CAST(logs.#{column.field.to_s} AS VARCHAR)").matches("%#{
            search_value}%")
      }
    end

end
