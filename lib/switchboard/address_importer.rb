module Switchboard
  class AddressImporter
    def self.from_row(row)
      # This looks like trouble. What if 2 addresses have the same line1?
      add = Address.find_or_initialize_by street_1: row[:address_line1]

      #add.street_1 = row[:address_line1]
      add.street_2 = row[:address_line2]
      add.city = row[:address_city]
      add.state = row[:address_province]
      add.postal_code = row[:address_postal_code]
      add.country_code = 'US'

      add
    end
  end
end

