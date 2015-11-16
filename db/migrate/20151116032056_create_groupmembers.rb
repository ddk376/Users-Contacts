class CreateGroupmembers < ActiveRecord::Migration
  def change
    create_table :groupmembers do |t|
      t.integer :group_id, null: false
      t.integer :contact_id, null: false
      t.timestamps null: false
    end
    add_index :groupmembers, :group_id
    add_index :groupmembers, :contact_id
  end
end
