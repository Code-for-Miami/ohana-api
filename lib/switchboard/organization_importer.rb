module Switchboard
  class OrganizationImporter
    def self.from_row(row)
      # same name, different whitespace
      name = row[:provider_parent_provider].squeeze(" ")

      org = Organization.find_or_initialize_by name: name
      org.description = name
      binding.pry unless org.save
      org.save!

      loc = Switchboard::LocationImporter.from_row row
      org.locations << loc
      loc.save!

      contact = Switchboard::ContactImporter.from_row row
      org.contacts << contact
      contact.save!

      phone = Switchboard::PhoneImporter.from_row row
      org.phones << phone
      if phone.valid?
        phone.save!
      else
        puts "Invalid phone number format"
        puts phone.errors.messages
      end

      org
    end
  end
end
