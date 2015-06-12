module Switchboard
  class PhoneImporter
    def self.from_row(row)
      self.from_field(row[:telephone_number])
    end

    def self.from_field(field)
      # Detect numbers with extensions
      # e.g. 305-235-8105 x5002
      number_ext = field.split("x").map(&:strip)
      phone = Phone.find_or_initialize_by number: number_ext[0], extension: number_ext[1]

      # assuming all of these are voice numbers
      # valid values are: :fax, :hotline, :sms, :tty, :voice
      phone.number_type = :voice

      phone
    end
  end
end
