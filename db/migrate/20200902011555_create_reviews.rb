class CreateReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :reviews do |t|
      t.text :content
      t.integer :rating
      t.belongs_to :user
      t.belongs_to :restaurant

      t.timestamps
    end
  end
end
