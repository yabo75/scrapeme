class CreateJobs < ActiveRecord::Migration[5.1]
  def change
    create_table :jobs do |t|
      t.string :title
      t.text :link
      t.string :city
      t.datetime :post_time

      t.timestamps
    end
  end
end
