namespace :db do
  desc 'Dump out all the data to a pg custom dump'
  task :dump => 'dump:custom'

  namespace :dump do
    desc 'Output a pg custom dump'
    task :custom => :environment do
      output_filename = Rails.root.join 'tmp', "#{Time.now.to_i}-#{Rails.env}.dump"
      dbname = OhanaApi::Application.config.database_configuration[Rails.env]['database']
      sh "pg_dump -Fc -f #{output_filename} #{dbname}"
    end

    desc 'Output a SQL dump'
    task :sql => :environment do
      output_filename = Rails.root.join 'tmp', "#{Time.now.to_i}-#{Rails.env}.sql"
      dbname = OhanaApi::Application.config.database_configuration[Rails.env]['database']
      sh "pg_dump -Fp -f #{output_filename} #{dbname}"
    end
  end
end
