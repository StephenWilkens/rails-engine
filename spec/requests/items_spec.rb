require 'rails_helper'

describe 'items API' do
  
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

    it "can update an existing item" do
      id = create(:item).id
      previous_name = Item.last.name
      item_params = { name: "Charlotte's Web" }
      headers = {"CONTENT_TYPE" => "application/json"}

      # We include this header to make sure that these params are passed as JSON rather than as plain text
      patch "/api/v1/items/#{id}", headers: headers, params: JSON.generate({item: item_params})
      item = Item.find_by(id: id)
      expect(response).to be_successful
      expect(item.name).to_not eq(previous_name)
      expect(item.name).to eq("Charlotte's Web")
    end

    it "can destroy an item" do
      item = create(:item)

      expect(Item.count).to eq(5)

      delete "/api/v1/items/#{item.id}"

      expect(response).to be_successful
      expect(Item.count).to eq(4)
      expect{Item.find(item.id)}.to raise_error(ActiveRecord::RecordNotFound)
    end

    it 'can find an items merchant' do
      get "/api/v1/items/#{items[0].id}/merchant"

      expect(response).to be_successful

      rb = JSON.parse(response.body, symbolize_names: true)
      merchant = rb[:data]
      
      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to be_an(String)
      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_a(String)
    end
  end
end