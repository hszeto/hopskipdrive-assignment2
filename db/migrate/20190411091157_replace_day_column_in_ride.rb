class ReplaceDayColumnInRide < ActiveRecord::Migration[5.2]
  def change
    remove_column :rides, :day 
  end
end
