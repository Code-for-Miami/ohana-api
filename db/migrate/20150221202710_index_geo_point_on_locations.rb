class IndexGeoPointOnLocations < ActiveRecord::Migration
  def change
    add_index :locations, :geo_point, using: :gist
  end
end
