class CreateLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :logs do |t|
      t.integer :main_id
      t.integer :sub_id
      t.string :model_type
      t.string :action_name
      t.integer :user_id
      t.text :description

      t.timestamps
    end
  end
end
