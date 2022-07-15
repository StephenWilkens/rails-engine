class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items

  validates_presence_of :name, :description, :unit_price

  def self.find_by_name(name)
    # Item.where(name: name)
    Item.where('name ILIKE ?', "%#{name}%")
        .order(:name)
        .first
  end

  def self.find_by_price_min(price)
    Item.where('unit_price >= ?', price)
      .order(:name)
      .first
  end

  def self.find_by_price_max(price)
    Item.where('unit_price <= ?', price)
      .order(:name)
      .first
  end

  def self.find_in_range(min, max)
    find_by_price_min(min).merge(Item.find_by_price_max(max))
  end

  def invoice_check
    Item.joins(invoice_items: :invoices)
        .where("invoice.items.count = 1")
        .destroy_all
  end
  
end
