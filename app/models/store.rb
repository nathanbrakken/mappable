class Store < ActiveRecord::Base
  attr_accessible :address, :name, :square_footage, :store_number, :x_coord, :y_coord, :brand_id, :status_id
  belongs_to :status
  belongs_to :brand
  validates_presence_of :address, :name, :square_footage, :store_number, :x_coord, :y_coord, :brand_id, :status_id
end
