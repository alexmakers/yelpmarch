require 'spec_helper'

describe 'writing reviews' do
  before { Restaurant.create(name: 'Nandos', address: '1 High St, London', cuisine: 'Chicken') }

  context 'logged out' do
    it 'does not show the review form' do
      visit '/restaurants'
      expect(page).not_to have_field('Thoughts')
    end
  end

  context 'logged in' do
    before do
      user = User.create(email: 'alex@a.com', password: '12345678', password_confirmation: '12345678')
      login_as user
    end

    specify 'restaurants begin with no reviews' do
      visit '/restaurants'
      expect(page).to have_content '0 reviews'
    end

    it 'adds the review to the restaurant', js: true do
      leave_review(4, 'This was decent')

      expect(current_path).to eq '/restaurants'
      expect(page).to have_content 'This was decent'
      expect(page).to have_content '1 review'
    end

    it 'calculates the average of reviews', js: true do
      leave_review(4, 'This was decent')
      leave_review(2, 'Poor!')

      expect(page).to have_content 'Average rating: 3'
    end
  end

  def leave_review(rating, thoughts)
    visit '/restaurants'

    fill_in 'Thoughts', with: thoughts
    select rating.to_s, from: 'Rating'
    click_button 'Leave Review'
  end

end