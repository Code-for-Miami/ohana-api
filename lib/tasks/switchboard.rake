namespace :switchboard do
  desc "Load data from ./data/switchboard/switchboard_data.csv"
  task import: :environment do
    INFILE = 'data/switchboard/switchboard_data.csv'
    unless File.exist?(INFILE)
      puts "CSV file missing: ${INFILE}"
    end

    # Debugging: display header row data
    DISPLAY_HEADERS = false
    def display_header_row(row)
      puts 'DEBUG MODE'
      puts "===", "Columns", "==="
      row.each_with_index do |col, idx|
        puts "#{idx},\"#{col.last}\""
      end
      puts "==="
    end

    first = true
    CSV.foreach(INFILE, 
                encoding: 'Windows-1251:UTF-8', 
                headers: true,
                return_headers: true,
                header_converters: :symbol,
               ) do |row|
      if first
        first = false
        display_header_row(row) if DISPLAY_HEADERS
        next
      end

      #  debugging
      #require 'pp'
      #pp row.to_hash

      Switchboard::OrganizationImporter.from_row(row)
    end
  end
end
