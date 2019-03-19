class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.string :recipient
      t.string :sender
      t.text :content_body
      t.integer :user_id
      t.boolean :sent, :default => false
      t.boolean :trash, :default => false
      t.boolean :archive, :default => false

      t.timestamps
    end
  end
end
