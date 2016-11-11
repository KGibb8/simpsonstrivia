class CreateEpisodes < ActiveRecord::Migration[5.0]
  def change
    create_table :episodes do |t|
      t.integer :episode_id
      t.string :title
      t.date :original_air_date
      t.string :production_code
      t.integer :season
      t.integer :number_in_season
      t.integer :number_in_series
      t.float :us_viewers_in_millions
      t.integer :views
      t.float :imdb_rating
      t.integer :imdb_votes
      t.text :image_url
      t.text :video_url

      t.timestamps
    end
  end
end
