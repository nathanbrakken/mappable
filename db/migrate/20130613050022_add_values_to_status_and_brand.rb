class AddValuesToStatusAndBrand < ActiveRecord::Migration
  def change
  	Brand.create :name => 'Sports'
  	Brand.create :name => 'Originals'
  	Brand.create :name => 'Outlet'
  	Status.create :name => 'Possible'
  	Status.create :name => 'Recent'
  	Status.create :name => 'Old'
  end
end
