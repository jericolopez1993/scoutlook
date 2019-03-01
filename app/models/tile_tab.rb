class TileTab < ApplicationRecord
  has_many :load_tiles, :dependent => :delete_all
  has_many :truck_tiles, :dependent => :delete_all
end
