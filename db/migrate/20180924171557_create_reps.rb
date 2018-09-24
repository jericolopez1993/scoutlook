class CreateReps < ActiveRecord::Migration[5.2]
  def change
    create_table :reps do |t|
      t.string :first_name
      t.string :last_name
      t.string :location
      t.date :date_of_hire
      t.string :rep_id
      t.string :parent_id
      t.string :phone
      t.string :email

      t.timestamps
    end
  end
end
