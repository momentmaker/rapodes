class CreateArtists < ActiveRecord::Migration
  def change
    create_table :artists do |t|
      t.integer :external_id
      t.string :name
      t.string :song_artist_id

      t.timestamps
    end
  end
end
