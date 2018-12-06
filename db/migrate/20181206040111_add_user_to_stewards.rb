class AddUserToStewards < ActiveRecord::Migration[5.2]
  def up
    add_column :reps, :user_id, :integer
  end

  def down
    remove_column :reps, :user_id
  end
end
