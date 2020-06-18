class Log < ApplicationRecord

  scope :today, -> do
    select("DISTINCT ON (main_id) logs.*, CONCAT(users.first_name, ' ', users.last_name) as user_name").joins("INNER JOIN users ON users.id = logs.user_id").where("logs.created_at >= ?", Time.zone.today.midnight).where.not(:main_id => nil).group("logs.id, users.id").order("logs.main_id,logs.created_at DESC")
  end

  scope :overall, -> do
    select("DISTINCT ON (main_id) logs.*, CONCAT(users.first_name, ' ', users.last_name) as user_name").joins("INNER JOIN users ON users.id = logs.user_id")
  end

end
