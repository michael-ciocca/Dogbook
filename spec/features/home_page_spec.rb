require 'rails_helper'

RSpec.feature 'Home page', type: :feature do
  scenario 'New user lands on site' do
    2.times { create(:dog) }

    visit '/'

    expect(page).to have_selector('.dog-photo', count: 2)
    expect(page).to have_selector('.dog-name', count: 2)

    expect(page).to have_text('Sign in')
    expect(page).to have_text('Sign up')
  end

  scenario 'More than 5 dogs exist' do
    10.times { create(:dog) }

    visit '/'

    expect(page).to have_selector('.pagination .next a')

    click_link('Next ›')

    expect(page).to have_selector('.dog-photo', count: 5)
    expect(page).to have_selector('.dog-name', count: 5)
  end
end
