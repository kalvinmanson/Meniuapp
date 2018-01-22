class CreatePlates < ActiveRecord::Migration[5.1]
  def change
    create_table :plates do |t|
      t.references :place, foreign_key: true
      t.string :name
      t.string :slug
      t.text :content
      t.boolean :favored
      t.boolean :active
      t.integer :price
      t.string :tags
      t.float :rank
      t.integer :views

      t.timestamps
    end
  end
end
