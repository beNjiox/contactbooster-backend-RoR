class AddContactsCountToListTable < ActiveRecord::Migration
  def change
    add_column :lists, :contacts_count, :integer, null: false, default: 0
  end
end
