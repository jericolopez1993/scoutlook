json.extract! activity, :id, :type, :engagement_type, :client_id, :rep_id, :annual_value, :status, :date_opened, :date_closed, :notes, :outcome_id, :created_at, :updated_at
json.url activity_url(activity, format: :json)
