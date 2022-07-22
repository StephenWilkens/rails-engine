class MerchantRevenueSerializer
  include JSONAPI::Serializer
  attributes :revenue do |merchant|
    merchant.revenue
  end
end