require 'rails_helper'

describe 'merchants_search controller' do
  describe 'find all merchants' do 
    let!(:merchant) do
      create :merchant, {
        name: 'Joy'
      }
    end
    let!(:merchant) do
      create :merchant, {
        name: 'John'
      }
    end
    let!(:merchant) do
      create :merchant, {
        name: 'Johnn'
      }
    end
    let!(:merchant) do
      create :merchant, {
        name: 'Larry'
      }
    end

    it 'can find all merchants by name' do
      get api_v1_merchants_find_all_path, params: { name: 'Jo'}

      rb = JSON.parse(response.body, symbolize_names: true)
      merchants = rb[:data]

      expect(merchants).to be_an(Array)
    end
  end
end