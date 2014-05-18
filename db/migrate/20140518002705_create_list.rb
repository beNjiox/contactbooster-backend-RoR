class CreateList < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.string 'name', null: false
      t.integer 'position', :limit => 2, null: false
    end
  end
end
