json.extract! load_tile, :id, :name, :status, :origin, :destination, :details, :created_at, :updated_at
json.url load_tile_url(load_tile, format: :json)
