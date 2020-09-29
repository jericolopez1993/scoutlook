class CreateEmailTemplates < ActiveRecord::Migration[5.2]
  def change
    create_table :email_templates do |t|
      t.string :name
      t.string :footer_description

      t.timestamps
    end
  end
end
