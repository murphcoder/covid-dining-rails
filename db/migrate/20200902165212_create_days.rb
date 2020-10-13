class CreateDays < ActiveRecord::Migration[6.0]
  def change
    create_table :days do |t|
      t.boolean :closed
      t.datetime :weekday
      t.datetime :opening_time
      t.datetime :closing_time
      t.belongs_to :restaurant

      t.timestamps
    end
  end
end
