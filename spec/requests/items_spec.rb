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
end