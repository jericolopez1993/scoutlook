class LoadTile < ApplicationRecord
  belongs_to :load_list, optional: true
end
