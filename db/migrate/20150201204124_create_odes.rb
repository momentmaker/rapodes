class CreateOdes < ActiveRecord::Migration
  def change
    create_table :odes do |t|
      t.integer :external_id
      t.string :title
      t.string :lyrics
      t.string :song_artist_id

      t.timestamps
    end
  end
end
