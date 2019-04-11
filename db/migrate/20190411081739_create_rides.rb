class CreateRides < ActiveRecord::Migration[5.2]
  def change
    create_table :rides do |t|
      t.integer :day
      t.string :time
      t.string :location
      t.references :repeating_ride, foreign_key: true

      t.timestamps
    end
  end
end
