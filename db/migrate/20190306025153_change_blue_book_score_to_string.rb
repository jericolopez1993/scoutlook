class ChangeBlueBookScoreToString < ActiveRecord::Migration[5.2]
  def up
        change_column :shippers, :blue_book_score, :string
    end
    def down
        change_column :shippers, :blue_book_score, :integer
    end
end
