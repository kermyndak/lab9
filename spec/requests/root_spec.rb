require 'rails_helper'
require 'nokogiri'

RSpec.describe "Roots", type: :request do
  describe "GET /input" do
    it "returns http success" do
      get root_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get root_show_path, params: { query: 350 }
      expect(response).to have_http_status(:success)
    end

    context 'returns http code 302' do
      it "empty parameter" do
        get root_show_path, params: {}
        expect(response).to have_http_status(302)
      end

      it "Bad input" do
        get root_show_path, params: { query: 'qwerty' }
        expect(response).to have_http_status(302)
      end
    end

    context 'controller tests' do
      it 'test @arr' do
        get root_show_path, params: { query: 350 }
        expect(assigns(:arr)).to eq([[1, 1], [6, 6], [28, 28], [220, 284]])
      end

      it 'test @number' do
        get root_show_path, params: { query: 350 }
        expect(assigns(:number)).to eq(350)
      end
    end

    context 'redirect to input' do
      it 'redirect with bad input' do
        get root_show_path, params: { query: 'qwerty' }
        expect(response).to redirect_to(root_path)
      end

      it 'redirect with empty input' do
        get root_show_path, params: {}
        expect(response).to redirect_to(root_path)
      end
    end

    context "parse answer" do
      it 'parameter 350' do
        get root_show_path, params: { query: 350 }
        html = Nokogiri::HTML(response.body)
        answer = [[1, 1], [6, 6], [28, 28], [220, 284]]
        td = html.search('td')
        answer.each_with_index do |pair, index|
          exp = [td[2 * index].text.to_i, td[1 + 2 * index].text.to_i]
          expect(exp).to eq(pair)
        end
      end
    end
  end
end
