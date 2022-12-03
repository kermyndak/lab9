require 'rails_helper'
require 'nokogiri'

RSpec.describe "Roots", type: :request do
  describe "GET /input" do
    it "returns http success" do
      get root_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /show" do
    it "returns http success" do
      post '/root/show', params: { query: 350 }, xhr: true
      expect(response).to have_http_status(:success)
    end

    context 'returns http code 200 with bad input' do
      it "Bad input" do
        post '/root/show', params: { query: 'qwerty' }, xhr: true
        expect(response).to have_http_status(200)
      end
    end

    context 'controller tests' do
      it 'test @arr' do
        post "/root/show", params: { query: 350 }, xhr: true
        expect(assigns(:arr)).to eq([[220, 284]])
      end

      it 'test @number' do
        post '/root/show', params: { query: 350 }, xhr: true
        expect(assigns(:number)).to eq(350)
      end
    end

    context "parse answer" do
      it 'parameter 350' do
        post '/root/show', params: { query: 350 }, xhr: true
        html = Nokogiri::HTML(response.body)
        answer = [[220, 284]]
        td = html.search('td')
        exp = [td[0].text.to_i, td[1].text.to_i]
        expect(exp).to eq([220, 284])
      end
    end
  end
end
