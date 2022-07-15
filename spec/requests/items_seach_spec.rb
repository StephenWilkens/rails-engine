require 'rails_helper'

describe 'items search' do
  describe 'return single item' do
    let!(:merchant) { create :merchant}
    let!(:item) do
      create :item, {
        name: 'boombox',
        description: 'slaps hard',
        unit_price: 99.98,
        merchant_id: merchant.id
      }
    end
    let!(:item_2) do
      create :item, {
        name: 'microphone',
        description: 'mostly works',
        unit_price: 19.98,
        merchant_id: merchant.id
      }
    end

    it 'can find an item by name' do

      get api_v1_items_find_path, params: { name: 'boombox' }

      expect(response).to be_successful

      rb = JSON.parse(response.body, symbolize_names: true)
      item = rb[:data]
      expect(item).to have_key(:id)
    end

    it 'can find an item by min_price' do

      get api_v1_items_find_path, params: { min_price: 20.01 }

      expect(response).to be_successful

      rb = JSON.parse(response.body, symbolize_names: true)
      item = rb[:data]

      expect(item).to be_an(Object)
      expect(item).to have_key(:id)
    end
  end
end