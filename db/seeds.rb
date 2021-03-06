ActiveRecord::Base.establish_connection
ActiveRecord::Base.connection.tables.each do |table|
  next if table == 'schema_migrations'

  if Rails.env.production?
    # MySQL and PostgreSQL
    ActiveRecord::Base.connection.execute("TRUNCATE #{table}")
  else
    # SQLite
    ActiveRecord::Base.connection.execute("DELETE FROM #{table}")
    ActiveRecord::Base.connection.execute("DELETE FROM SQLITE_SEQUENCE WHERE NAME = '#{table}'")
  end
end

3.times do
  list = FactoryGirl.create(:list)
  5.times do
    FactoryGirl.create(:contact, list_id: list.id)
  end
end