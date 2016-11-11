class CreateLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :locations do |t|
      t.integer :location_id
      t.string :name
      t.string :normalized_name

      t.timestamps
    end
  end
end
