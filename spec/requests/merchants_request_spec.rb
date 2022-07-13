require 'rails_helper'

describe 'Merchants API' do

  it 'sends a all merchants' do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    expect(response).to be_successful

    response_body = JSON.parse(response.body, symbolize_names: true)
    merchants = response_body[:data]

    expect(merchants).to be_an(Array)
    expect(merchants.count).to eq(3)

    merchants.each do |merchant|

      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to be_an(String)

      expect(merchant[:type]).to be_a(String)

      expect(merchant).to have_key(:attributes)
      expect(merchant[:attributes]).to be_a(Hash)

      expect(merchant[:attributes][:name]).to be_a(String)
    end
  end

  it 'can get one merchant by its id' do
    id = create(:merchant).id

    get "/api/v1//merchants/#{id}"

    rb = JSON.parse(response.body, symbolize_names: true)
    merchant = rb[:data]

    expect(merchant).to have_key(:id)
    expect(merchant).to have_key(:attributes)
    expect(merchant[:attributes][:name]).to be_a(String)

  end
end