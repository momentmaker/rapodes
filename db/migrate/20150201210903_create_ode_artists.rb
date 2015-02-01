class CreateOdeArtists < ActiveRecord::Migration
  def change
    create_table :ode_artists do |t|
      t.string :ode_id
      t.string :artist_id

      t.timestamps
    end
  end
end
