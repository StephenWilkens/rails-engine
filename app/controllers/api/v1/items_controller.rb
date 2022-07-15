class Api::V1::ItemsController < ApplicationController
  before_action :set_item, only: [:show, :update, :destroy]

  # GET /items
  def index
    #@items = ItemSerializer.new(Item.all)
    render json: ItemSerializer.new(Item.all)
  end

  # GET /items/1
  def show
    #render json: @item
    render json: ItemSerializer.new(@item)
  end

  # POST /items
  def create
    # require "pry"; binding.pry
    @item = Item.new(item_params)

    if @item.save
      render json: ItemSerializer.new(@item), status: :created
    else
      render json: @item.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /items/1
  def update
    if @item.update(item_params)
      render json: ItemSerializer.new(@item), status: :ok
    else
      render json: {error: 'could not update item'}, status: 404
    end
  end

  # DELETE /items/1
  def destroy
    @item.invoice_check
    @item.destroy
  end

  def merchant_find
    item = Item.find(params[:item_id])
    render json: MerchantSerializer.new(item.merchant)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def item_params
      params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
    end
end
