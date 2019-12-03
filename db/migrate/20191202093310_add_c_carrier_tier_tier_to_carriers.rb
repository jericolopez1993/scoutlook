class AddCCarrierTierTierToCarriers < ActiveRecord::Migration[5.2]
  def change
    add_column :carriers, :c_carr_tier_tier, :string
  end
end
