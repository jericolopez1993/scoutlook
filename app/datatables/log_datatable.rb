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
      user_name: { source: "user_name" },
      created_at: { source: "Log.created_at" },
      auditable_type: { source: "Log.description" },
      user_id: { source: "Log.user_id" },
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
    Log.overall.where.not(:main_id => nil).group("logs.id, users.id").order("logs.main_id,logs.created_at DESC")
  end

  def user
    @user ||= options[:user]
  end

end
