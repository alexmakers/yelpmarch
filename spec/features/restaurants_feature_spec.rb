require 'spec_helper'

describe 'restaurants index page' do
  context 'no restaurants have been added' do
    it 'should display a message' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet'
    end
  end
end

describe 'creating a restaurant' do
  it 'adds it to the restaurants index' do
    visit '/restaurants/new'
    fill_in 'Name', with: 'Nandos'
    fill_in 'Address', with: '1 City Road, London'
    click_button 'Create Restaurant'

    expect(current_path).to eq '/restaurants'
    expect(page).to have_content 'Nandos'
  end
end

describe 'editing a restaurant' do
  before { Restaurant.create(name: 'KFC', address: '1 High St, London') }

  it 'saves the change to the restaurant' do
    visit '/restaurants'
    click_link 'Edit KFC'

    fill_in 'Name', with: 'Kentucky Fried Chicken'
    click_button 'Update Restaurant'

    expect(current_path).to eq '/restaurants'
    expect(page).to have_content 'Kentucky Fried Chicken'
  end
end

describe 'deleting a restaurant' do
  before { Restaurant.create(name: 'KFC', address: '1 High St, London') }

  it 'removes the restaurant from the listing' do
    visit '/restaurants'
    click_link 'Delete KFC'

    expect(page).not_to have_content 'KFC'
    expect(page).to have_content 'Deleted successfully'
  end
end