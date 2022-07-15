class Api::V1::MerchantsSearchController < ApplicationController
  def find_all
    if params[:name]
      merchants = Merchant.find_merch_by_name(params[:name])
      if merchants.nil?
        render json: { data: { error: 'No merchant matches search parameters' } },
               status: 200
      else
        render json: MerchantSerializer.new(merchants)
      end
    end
  end
end