class CreateStores < ActiveRecord::Migration
  def change
    create_table :stores do |t|
      t.string :name
      t.string :x_coord
      t.string :y_coord
      t.string :brand_type
      t.string :address
      t.string :status
      t.string :store_number
      t.string :status
      t.string :square_footage
      t.integer :brand_id
      t.integer :status_id
      
      t.timestamps
    end
  end
end
