class Log < ApplicationRecord

  scope :today, -> do
    select("logs.main_id, MAX(sub_id) AS sub_id, MAX(logs.id) AS id, MAX(model_type) AS model_type, MAX(description) AS description, MAX(logs.created_at) AS created_at, MAX(user_id) AS user_id, MAX(CONCAT(users.first_name, ' ', users.last_name)) as user_name").joins("INNER JOIN users ON users.id = logs.user_id").group("logs.main_id").where("logs.created_at >= ?", Time.zone.today.midnight).where.not(:main_id => nil).where.not(:user_id => nil).group("logs.id, users.id").order("logs.created_at DESC")
  end

  scope :overall, -> do
    select("logs.main_id, MAX(sub_id) AS sub_id, MAX(logs.id) AS id, MAX(model_type) AS model_type, MAX(description) AS description, MAX(logs.created_at) AS created_at, MAX(user_id) AS user_id, MAX(CONCAT(users.first_name, ' ', users.last_name)) as user_name").joins("INNER JOIN users ON users.id = logs.user_id").group("logs.main_id").where.not(:main_id => nil).where.not(:user_id => nil)
  end

end
