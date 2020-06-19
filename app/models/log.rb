class Log < ApplicationRecord

  scope :today, -> do
    select("logs.*, CONCAT(users.first_name, ' ', users.last_name) as user_name").joins("INNER JOIN users ON users.id = logs.user_id").where("(logs.main_id, logs.created_at) IN (SELECT logs2.main_id, MAX(logs2.created_at) FROM logs AS logs2 GROUP BY logs2.main_id)").where.not(:main_id => nil).where.not(:user_id => nil).where("logs.created_at >= ?", Time.zone.today.midnight).order("created_at DESC")
  end

  scope :overall, -> do
    select("logs.*, CONCAT(users.first_name, ' ', users.last_name) as user_name").joins("INNER JOIN users ON users.id = logs.user_id").where("(logs.main_id, logs.created_at) IN (SELECT logs2.main_id, MAX(logs2.created_at) FROM logs AS logs2 GROUP BY logs2.main_id)").where.not(:main_id => nil).where.not(:user_id => nil)
  end

end
