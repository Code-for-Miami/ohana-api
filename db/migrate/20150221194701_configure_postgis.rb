class ConfigurePostgis < ActiveRecord::Migration
  def up
    enable_extension 'postgis'
  end
end
