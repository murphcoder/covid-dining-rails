class CreateRestaurants < ActiveRecord::Migration[6.0]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.text :address
      t.boolean :carryout
      t.boolean :outdoor_dining
      t.boolean :indoor_dining
      t.boolean :follows_rules
      t.belongs_to :author, :class_name => "User"

      t.timestamps
    end
  end
end
