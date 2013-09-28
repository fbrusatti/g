class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :image
      t.references :property

      t.timestamps
    end
    add_index :photos, :image
  end
end
