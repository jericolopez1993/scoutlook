class RemoveLinkedinAndWebsiteInCarrier < ActiveRecord::Migration[5.2]
  def change
    remove_column :carriers, :linkedin
    remove_column :carriers, :website
  end
end
