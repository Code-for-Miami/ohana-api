module Switchboard
  class ServiceImporter
    def self.find_by_row(row)
      Service.find_by name: row[:provider_name]
    end

    def self.from_row(row)
      ser = Service.find_or_initialize_by name: row[:provider_name]

      ser.alternate_name = row[:provider]
      #ser.name = row[:provider_name]
      ser.description = row[:provider_description]
      ser.eligibility = row[:provider_eligibility]
      ser.how_to_apply = row[:provider_intake__application_process]
      ser.languages = row[:provider_languages].split(',').map(&:strip)
      ser.fees = row[:provider_program_fees]

      website = row[:provider_website_address]
      ser.website = website.start_with?('http') ? website : "http://#{website}"
      ser
    end
  end
end
