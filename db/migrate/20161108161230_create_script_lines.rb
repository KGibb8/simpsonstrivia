class CreateScriptLines < ActiveRecord::Migration[5.0]
  def change
    create_table :script_lines do |t|
      t.integer :script_id
      t.integer :episode_id
      t.string :number
      t.text :raw_text
      t.integer :timestamp_in_ms
      t.string :speaking_line
      t.integer :character_id
      t.integer :location_id
      t.string :raw_character_text
      t.string :raw_location_text
      t.text :spoken_words
      t.text :normalized_text
      t.integer :word_count

      t.timestamps
    end
  end
end
