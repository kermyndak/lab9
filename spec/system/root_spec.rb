require 'rails_helper.rb'

RSpec.describe 'Static content', type: :system do
  let(:input) { 1500 }
  let(:bad) { Faker::Lorem.word }

  scenario 'Input value' do
    visit root_path
    fill_in :query, with: input
    find(".btn").click
    expect(find('#result')).to have_text("Дружественные числа\nЧисло Число\n220 284\n1184 1210")
  end

  scenario 'Bad input' do
    visit root_path
    fill_in :query, with: bad
    find(".btn").click
    expect(find('#result')).to have_text('Bad input...')
  end
end