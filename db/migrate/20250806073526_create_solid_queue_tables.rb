class CreateSolidQueueTables < ActiveRecord::Migration[7.1]
  def change
    create_table :solid_queue_jobs do |t|
      t.string :queue_name, null: false
      t.string :job_class, null: false
      t.text :arguments
      t.datetime :scheduled_at
      t.datetime :finished_at
      t.integer :priority, default: 0, null: false
      t.timestamps
    end

    create_table :solid_queue_processes do |t|
      t.string :name, null: false
      t.datetime :last_heartbeat_at, null: false
      t.timestamps
    end

    create_table :solid_queue_assignments do |t|
      t.references :solid_queue_process, foreign_key: true
      t.references :solid_queue_job, foreign_key: true
      t.timestamps
    end

    add_index :solid_queue_jobs, :queue_name
    add_index :solid_queue_jobs, :scheduled_at
    add_index :solid_queue_processes, :name, unique: true
  end
end
