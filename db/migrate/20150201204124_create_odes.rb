class CreateOdes < ActiveRecord::Migration
  def change
    create_table :odes do |t|
      t.integer :external_id
      t.string :title
      t.text :lyrics

      t.timestamps
    end
  end
end
