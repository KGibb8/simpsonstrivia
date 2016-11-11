class CreateCharacters < ActiveRecord::Migration[5.0]
  def change
    create_table :characters do |t|
      t.integer :character_id
      t.string :name
      t.string :normalized_name
      t.string :gender

      t.timestamps
    end
  end
end
