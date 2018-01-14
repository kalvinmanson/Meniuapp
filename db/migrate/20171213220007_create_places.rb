class CreatePlaces < ActiveRecord::Migration[5.1]
  def change
    create_table :places do |t|
      t.references :user, foreign_key: true
      t.references :category, foreign_key: true
      t.string :name
      t.string :slug
      t.string :address
      t.string :phone
      t.string :email
      t.text :description
      t.float :rank
      t.integer :views
      t.float :lat
      t.float :lng
      t.date :expires_at

      t.timestamps
    end
  end
end
