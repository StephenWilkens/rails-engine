class Api::V1::Revenue::MerchantsController < ApplicationController
  def index
    merchants = Merchant.top_merchants_by_revenue(params[:quantity])
    render json: MerchantNameRevenueSerializer.new(merchants)
  end

  def show
    #require "pry"; binding.pry
    merchant = Merchant.total_revenue(params[:id])
    render json: MerchantRevenueSerializer.new(merchant)
  end
end