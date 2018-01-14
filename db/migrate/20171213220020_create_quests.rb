class CreateQuests < ActiveRecord::Migration[5.1]
  def change
    create_table :quests do |t|
      t.references :user, foreign_key: true
      t.string :quest
      t.integer :visited_place
      t.integer :visited_plate
      t.float :lat
      t.float :lng

      t.timestamps
    end
  end
end
