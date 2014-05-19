class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.belongs_to :list
      t.string :firstname
      t.string :lastname
      t.string :phone
      t.timestamps
    end
    add_index :contacts, :list_id
  end
end
