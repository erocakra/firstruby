class Data::DatabaseDumper
	def self.get_rails_db_config(connection_name="")
      rails_config = Rails.configuration.database_configuration
      config_key   = connection_name.empty? ? "" : "#{connection_name}_"
      config_key   = config_key + Rails.env
      rails_config[config_key] 
    end 

    def self.open_connection(connection_name="")
      config = get_rails_db_config(connection_name)

      raise Exception, "Expected connection name doesn't exist" if config.nil?

      opts            = {}
      opts[:dbname]   = config["database"] unless config["database"].nil?
      opts[:password] = config["password"] unless config["password"].nil?
      opts[:host]     = config["host"]     unless config["host"].nil?
      opts[:user]     = config["username"] unless config["username"].nil?
      @@connection= PG.connect(opts)
    end

	def self.backup_to_csv(table_name)
		query = <<-SQL
			COPY #{table_name} TO 'D:/#{table_name}_backup.csv' DELIMITER ',' CSV HEADER;
		SQL

		ActiveRecord::Base.connection.execute(query)

	end
end