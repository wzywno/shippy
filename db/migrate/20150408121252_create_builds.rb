class CreateBuilds < ActiveRecord::Migration
  def change
    create_table :builds do |t|
      t.integer :status
      t.integer :duration
      t.datetime :starttime
      t.datetime :endtime
      t.text :log

      t.timestamps null: false
    end
    add_index :builds, :status
  end
end
