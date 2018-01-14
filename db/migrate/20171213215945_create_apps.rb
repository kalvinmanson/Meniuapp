class CreateApps < ActiveRecord::Migration[5.1]
  def change
    create_table :apps do |t|
      t.references :user, foreign_key: true
      t.string :public_key
      t.string :private_key
      t.string :domains

      t.timestamps
    end
  end
end
