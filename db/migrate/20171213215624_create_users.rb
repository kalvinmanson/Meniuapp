class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :uid
      t.string :provider
      t.string :role
      t.string :name
      t.string :image
      t.boolean :active
      t.float :lat
      t.float :lng

      t.timestamps
    end
  end
end
