class CreateJobs < ActiveRecord::Migration[5.1]
  def self.up
  create_table :jobs do |t|
    t.string :title
    t.text :link
    t.string :city
    t.datetime :post_time

    t.timestamps
  end

  add_index :jobs, :post_time
  add_index :jobs, :city
  add_index :jobs, :title
  add_index :jobs, :link, :unique => true
  end

  def self.down
  drop_table :jobs
  end
end
