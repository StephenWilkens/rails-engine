class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy

  validates_presence_of :name

  def self.find_merch_by_name(name)
    Merchant.where('name ILIKE ?', "%#{name}%")
        .order(:name)
  end
end
