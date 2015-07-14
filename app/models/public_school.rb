class PublicSchool < ActiveRecord::Base
  def locations_in_miles(miles = 0.25)
    meters = 1_609.344 * miles

    my_location = "select wkb_geometry from public_schools where id = #{id}"

    clause = "st_distance(geo_point, (#{my_location})) < :meters"

    Location.where(clause, meters: meters)
  end
end
