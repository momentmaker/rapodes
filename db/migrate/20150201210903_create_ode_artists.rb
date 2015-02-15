class CreateOdeArtists < ActiveRecord::Migration
  def change
    create_table :ode_artists do |t|
      t.integer :ode_id
      t.integer :artist_id

      t.timestamps
    end
  end
end
