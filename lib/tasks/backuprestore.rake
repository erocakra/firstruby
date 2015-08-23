namespace :backuprestore do
  
  desc "Dump database to D:/DB_Dump/APP_NAME.sql"
  task :backup_database => :environment do
    cmd = nil
    with_config do |app, host, db, user, pass|
      cmd = "pg_dump -U #{user} --password #{pass} #{db} > D:/DB_Dump/#{app}.sql"
    end
    puts cmd
    exec cmd
  end

  desc "Restores the database at D:/DB_Dump/APP_NAME.sql"
  task restore_database: :environment do
    cmd = nil
    with_config do |app, host, db, user, pass|
      cmd = "pg_restore --verbose --host #{host} --username #{user} --clean --no-owner --no-acl --dbname #{db} D:/DB_Dump/#{app}.sql"
    end
    Rake::Task["db:drop"].invoke
    Rake::Task["db:create"].invoke
    puts cmd
    exec cmd
  end

  desc "Create a csv file as a backup data for certain table"
  task :backup_table_csv, [:table_name] do |t, args|
    puts "Copying table #{args[:table_name]} into D:/#{args[:table_name]}_backup.csv"
    query = "COPY employee to 'D:/DB_Dump/#{args[:table_name]}.csv' DELIMITER ',' CSV HEADER;"

    opts            = {}
    with_config do |app, host, db, user, pass|
      opts[:adapter]  = "postgresql"
      opts[:dbname]   = db
      opts[:password] = pass
      opts[:host]     = "localhost"
      opts[:user]     = user
    end

    #connection = ActiveRecord::Base.establish_connection(opts)
    connection = PG.connect(opts)
    connection.exec query
=begin
    puts "Copying table #{args[:table_name]} into D:/#{args[:table_name]}_backup.csv" 
    Data::DatabaseDumper.backup_to_csv(args[:table_name])
    puts "Copying complete"
=end
  end

  desc "Create table from certain csv file"
  task restore_table_csv: :environment do
  end

  desc "Test"
  task test: :environment do
  end

  private
  def with_config
    yield Rails.application.class.parent_name.underscore,
      ActiveRecord::Base.connection_config[:host],
      ActiveRecord::Base.connection_config[:database],
      ActiveRecord::Base.connection_config[:username],
      ActiveRecord::Base.connection_config[:password]
  end
end
