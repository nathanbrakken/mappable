class CreateBrands < ActiveRecord::Migration
  def change
    create_table :brands do |t|
      
      t.text :name

      t.timestamps
    end
  end
end
