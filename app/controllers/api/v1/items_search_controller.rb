class Api::V1::ItemsSearchController < ApplicationController
   
  def find
    item = Item.find_item(params[:name])
    if item.nil?
      render json: { data: { error: 'No item matches search parameters' } },
             status: 200
    else
      render json: ItemSerializer.new(item)
    end
  end
end