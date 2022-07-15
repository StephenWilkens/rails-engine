class Api::V1::ItemsSearchController < ApplicationController
   
  def find
    if params[:name] && params[:min_price]
      render json: { data: { error: 'Can not search with by both name and price' } },
               status: 400
    elsif params[:name] && params[:max_price]
      render json: { data: { error: 'Can not search with by both name and price' } },
               status: 400
    elsif params[:min_price].to_i < 0
      render json: { error: { error: 'Price can not be zero' } },
               status: 400
    elsif params[:max_price].to_i < 0
      render json: { error: { error: 'Price can not be zero' } },
               status: 400
    elsif params[:name]
      item = Item.find_by_name(params[:name])
      if item.nil?
        render json: { data: { error: 'No item matches search parameters' } },
               status: 200
      else
        render json: ItemSerializer.new(item)
      end
    elsif params[:min_price] && params[:max_price]
      item = Item.find_in_range(params[:min_price], params[:max_price])
      if item.nil?
        render json: { data: { error: 'No item matches search parameters' } },
               status: 200
      else
        render json: ItemSerializer.new(item)
      end
    elsif params[:min_price]
      item = Item.find_by_price_min(params[:min_price])
      if item.nil?
        render json: { data: { error: 'No item matches search parameters' } },
               status: 200
      else
        render json: ItemSerializer.new(item)
      end
    elsif params[:max_price]
      item = Item.find_by_price_max(params[:max_price])
      if item.nil?
        render json: { data: { error: 'No item matches search parameters' } },
               status: 200
      else
        render json: ItemSerializer.new(item)
      end
    else
      render json: { data: { error: 'Parameters not searchable' } },
               status: 400
      end
  end
end