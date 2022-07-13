require 'rails_helper'

describe 'items API' do
  describe 'Merchants items' do
    let!(:merchant) { create :merchant }
    let!(:items) { create_list :item, 4, { merchant_id: merchant.id } }

    it 'sends all of one merchants items' do
      get "/api/v1/merchants/#{merchant.id}/items"

      expect(response).to be_successful

      rb = JSON.parse(response.body, symbolize_names: true)
      items = rb[:data]

      expect(items).to be_an(Array)
      expect(items.count).to eq(4)

      items.each do |item|
        expect(item).to have_key(:id)
        expect(item[:id]).to be_an(String)

        expect(item[:type]).to be_a(String)

        expect(item).to have_key(:attributes)
        expect(item[:attributes]).to be_a(Hash)

        expect(item[:attributes][:name]).to be_a(String)
      end
    end
  end

  describe 'items routes' do
    let!(:merchant_1) { create :merchant }
    let!(:merchant_2) { create :merchant }
    let!(:items) { create_list :item, 4, { merchant_id: merchant_1.id } }

    it 'can find all items' do
      get "/api/v1/items"

      expect(response).to be_successful

      rb = JSON.parse(response.body, symbolize_names: true)
      items = rb[:data]

      expect(items).to be_an(Array)
      expect(items.count).to eq(4)

      items.each do |item|
        expect(item).to have_key(:id)
        expect(item[:id]).to be_an(String)

        expect(item[:type]).to be_a(String)

        expect(item).to have_key(:attributes)
        expect(item[:attributes]).to be_a(Hash)

        expect(item[:attributes][:name]).to be_a(String)
      end
    end

    it 'can find a specific item by id' do
      get "/api/v1/items/#{items[0].id}"

      expect(response).to be_successful

      rb = JSON.parse(response.body, symbolize_names: true)
      item = rb[:data]

      expect(item).to have_key(:id)
      expect(item[:id]).to be_an(String)

      expect(item[:type]).to be_a(String)

      expect(item).to have_key(:attributes)
      expect(item[:attributes]).to be_a(Hash)

      expect(item[:attributes][:name]).to be_a(String)
    end

    it 'can create a new item' do

      item_params = ({
                      name: 'Pen',
                      description: 'Ballpoint, space certified',
                      unit_price: 44.22,
                      merchant_id: "#{merchant_2.id}"
                    })
      headers = {"CONTENT_TYPE" => "application/json"}

      # We include this header to make sure that these params are passed as JSON rather than as plain text
      post "/api/v1/items", headers: headers, params: JSON.generate(item: item_params)
      created_item = Item.last

      expect(response).to be_successful
      expect(created_item.name).to eq(item_params[:name])
      expect(created_item.description).to eq(item_params[:description])
      expect(created_item.unit_price).to eq(item_params[:unit_price])
    end
  end
end