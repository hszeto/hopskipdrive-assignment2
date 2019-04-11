class CreateRepeatingRides < ActiveRecord::Migration[5.2]
  def change
    create_table :repeating_rides do |t|
      t.integer :frequency
      t.string :location
      t.string :time
      t.text :days, default: [].to_yaml
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
