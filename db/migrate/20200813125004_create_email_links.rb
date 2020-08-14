class CreateEmailLinks < ActiveRecord::Migration[5.2]
  def change
    create_table :email_links do |t|
      t.integer :position
      t.string :link

      t.timestamps
    end
  end
end
