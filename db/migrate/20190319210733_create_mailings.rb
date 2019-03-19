class CreateMailings < ActiveRecord::Migration[5.2]
  def change
    create_table :mailings do |t|
      t.string :recipient
      t.string :cc
      t.string :bcc
      t.string :sender
      t.string :subject
      t.text :content_body
      t.integer :user_id
      t.boolean :sent, :default => false
      t.boolean :trash, :default => false
      t.boolean :archive, :default => false

      t.timestamps
    end
  end
end
