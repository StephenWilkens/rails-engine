class Item < ApplicationRecord
  belongs_to :merchant

  validates_presence_of :name, :description, :unit_price

  def self.find_item(params)
    # Item.where(name: params)
    Item.where('name ILIKE ?', "%#{params}%")
        .order(:name)
        .first
  end
end
