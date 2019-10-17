class Add5wAnd6wToCarrNew < ActiveRecord::Migration[5.2]
  def change
    unless column_exists? :carr_new, :loads_5w
      add_column :carr_new, :loads_5w, :integer
    end
    unless column_exists? :carr_new, :loads_6w
      add_column :carr_new, :loads_6w, :integer
    end
  end
end
