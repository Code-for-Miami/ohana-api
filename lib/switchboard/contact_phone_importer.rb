module Switchboard
  class ContactPhoneImporter
    def self.from_row(row)
      Switchboard::PhoneImporter.from_field(row[:contact_telephone_number])
    end
  end
end
