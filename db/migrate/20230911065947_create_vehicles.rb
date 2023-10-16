class CreateVehicles < ActiveRecord::Migration[6.1]
  def change
    create_table :vehicles do |t|
      t.string :city
      t.integer :mileage
      t.string :carModel
      t.integer :price
      t.string :engineType
      t.string :transmissonType
      t.string :engineCapicity
      t.string :color
      t.string :assemblyType
      t.string :description
      t.string :primaryContact
      t.string :secondaryContact

      t.timestamps
    end
  end
end
