class AddMileageToDfLoads < ActiveRecord::Migration[5.2]
  def change
    unless column_exists? :df_loads, :mileage
      add_column :df_loads, :mileage, :bigint
    end
    unless column_exists? :df_loads, :ttt_rpm
      add_column :df_loads, :ttt_rpm, :float
    end
    unless column_exists? :df_loads, :bill_rpm
      add_column :df_loads, :bill_rpm, :float
    end
  end
end
