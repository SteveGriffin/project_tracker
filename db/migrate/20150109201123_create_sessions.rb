class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.integer :project_id
      t.datetime :start_time
      t.datetime :end_time
      t.integer :task_id

      t.timestamps
    end
  end
end
