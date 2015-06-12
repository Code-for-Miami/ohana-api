module Switchboard
  class ContactImporter
    def self.from_row(row)
      contact = Contact.find_or_initialize_by email: row[:contact_email]

      contact.name = row[:contact_name]
      contact.title = row[:contact_title]
      #contact.email = row[:contact_email]

      phone = Switchboard::ContactPhoneImporter.from_row(row)
      contact.phones << phone
      phone.save!

      contact
    end
  end
end
