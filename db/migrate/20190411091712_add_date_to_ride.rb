class AddDateToRide < ActiveRecord::Migration[5.2]
  def change
    add_column :rides, :date, :string
  end
end
