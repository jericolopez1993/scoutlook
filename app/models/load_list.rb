class LoadList < ApplicationRecord
  has_many :load_tile, :dependent => :delete_all
end
