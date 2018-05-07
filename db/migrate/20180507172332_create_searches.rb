class CreateSearches < ActiveRecord::Migration[5.1]
  def change
    create_table :searches do |t|
      t.string :search_terms
      t.boolean :telecommute
      t.boolean :full_time

      t.timestamps
    end

    add_index :searches, :search_terms
    add_index :searches, :telecommute
    add_index :searches, :full_time
  end

    def self.down
    drop_table :searches
    end

end
