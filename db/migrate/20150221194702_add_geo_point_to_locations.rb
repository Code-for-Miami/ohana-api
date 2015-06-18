class AddGeoPointToLocations < ActiveRecord::Migration
  def change
    enable_extension 'postgis'
    add_column :locations, :geo_point, 'geography(point, 4326)'

    Location.connection.execute <<-SQL
      UPDATE locations
        SET geo_point = ST_MakePoint(
          longitude,
          latitude)
        WHERE latitude IS NOT NULL AND longitude IS NOT NULL
      SQL
  end
end
