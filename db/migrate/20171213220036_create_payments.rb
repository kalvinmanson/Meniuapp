class CreatePayments < ActiveRecord::Migration[5.1]
  def change
    create_table :payments do |t|
      t.references :place, foreign_key: true
      t.integer :months
      t.integer :total
      t.string :status
      t.text :comments

      t.timestamps
    end
  end
end
