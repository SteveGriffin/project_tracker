class AddIndexToSessions < ActiveRecord::Migration
  def change
    add_column :sessions, :user_id, :integer
    add_index :sessions, :user_id
  end
end
