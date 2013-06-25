class Store < ActiveRecord::Base
  acts_as_xlsx
  attr_accessible :address, :name, :square_footage, :store_number, :x_coord, :y_coord, :brand_id, :status_id
  belongs_to :status
  belongs_to :brand
  validates_presence_of :address, :name, :square_footage, :store_number, :brand_id, :status_id

  def self.generate_csv(fields, records, options = {})
    CSV.generate(options) do |csv|
      csv << fields.collect(&:humanize)
      records.each do |record|
        # binding.pry
        csv << record.attributes.values_at(*fields)
      end
    end
  end


end
