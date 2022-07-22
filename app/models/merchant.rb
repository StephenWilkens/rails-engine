class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoices, dependent: :destroy
  has_many :invoice_items, through: :invoices
  has_many :transactions, through: :invoices

  validates_presence_of :name

  def self.find_merch_by_name(name)
    Merchant.where('name ILIKE ?', "%#{name}%")
        .order(:name)
  end

  def self.top_merchants_by_revenue(quantity)
    joins(invoices: [:invoice_items, :transactions])
    .where(transactions: { result: 'success' }, invoices: { status: 'shipped' })
    .select(:name, :id, 'SUM(invoice_items.quantity * invoice_items.unit_price) as revenue')
    .group(:id)
    .order(revenue: :desc)
    .limit(quantity)
  end

  def self.top_merchants_by_items_sold(quantity)
    joins(invoices: [:invoice_items, :transactions])
    .where(transactions: { result: 'success' }, invoices: { status: 'shipped' })
    .select(:name, :id, 'SUM(invoice_items.quantity) as counted')
    .group(:id)
    .order(counted: :desc)
    .limit(quantity)
  end
end
