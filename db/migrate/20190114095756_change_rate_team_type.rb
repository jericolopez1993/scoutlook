class ChangeRateTeamType < ActiveRecord::Migration[5.2]
  def up
        change_column :rates, :team, :string
    end
    def down
        change_column :rates, :team, :boolean
    end
end
