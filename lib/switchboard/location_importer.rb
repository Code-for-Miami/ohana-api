module Switchboard
  class LocationImporter
    def self.from_row(row)
      service = Switchboard::ServiceImporter.find_by_row(row)

      if service.nil?
        service = Switchboard::ServiceImporter.from_row(row)

        loc = Location.find_or_initialize_by name: row[:provider_parent_provider]
        loc.description = loc.name
        loc.services << service

        service.save!

      else
        loc = service.location
        # TODO: update service?
      end

      # Is this the service address or the organization address?
      # Ohana only supports org.location addresses
      if row[:address_type] == 'Physical'
        add = Switchboard::AddressImporter.from_row(row)
        loc.address = add
        add.save!
      elsif row[:address_type] == 'Mailing'
        madd = Switchboard::MailAddressImporter.from_row(row)
        loc.mail_address = madd
        madd.save!
        # If this is the Service address:
        # self.mail_address = MailAddress.new(row)
      else
        puts "What's this?", row
      end

      # If there's only a mailing address and no physical address,
      # assume the location is "virtual" only.
      loc.virtual = loc.address.nil?

      loc
    end
  end
end
