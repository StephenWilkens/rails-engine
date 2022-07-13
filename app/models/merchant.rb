class Merchant < ApplicationRecord
  has_many :items, dependant: :destroy

  validates_presence_of :name
end
