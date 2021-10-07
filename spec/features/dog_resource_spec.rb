require 'rails_helper'

describe 'Dog resource', type: :feature do
  it 'can create a profile' do
    visit new_dog_path
    fill_in 'Name', with: 'Speck'
    fill_in 'Description', with: 'Just a dog'
    attach_file 'Image', ['spec/fixtures/images/speck.jpg', 'spec/fixtures/images/dog2.jpeg' ]
    click_button 'Create Dog'
    expect(Dog.count).to eq(1)
    expect(Dog.last.images.count).to eq(2)
  end

  context "user logged in and owns dog" do
    let(:user) { FactoryBot.create(:user) }
    let!(:dog) { FactoryBot.create(:dog, owner: user) }

    before do
      login_as(user, :scope => :user)
    end

    it 'can edit a dog profile' do
      visit edit_dog_path(dog)
      fill_in 'Name', with: 'Speck'
      click_button 'Update Dog'
      expect(dog.reload.name).to eq('Speck')
    end

    it 'can delete a dog profile' do
      visit dog_path(dog)
      click_link "Delete #{dog.name}'s Profile"
      expect(Dog.count).to eq(0)
    end
  end

  context "when logged in user is not the owner" do
    let(:user) { FactoryBot.create(:user) }
    let(:owner) { FactoryBot.create(:user) }
    let!(:dog) { FactoryBot.create(:dog, owner: owner) }

    before do
      login_as(user, :scope => :user)
    end

    it "cannot edit the dog's profile" do
      visit edit_dog_path(dog)
      text = page.find('.notice').text
      expect(text).to eq "Cannot modify a dog you do not own"
    end

    it "cannot delete a dog profile" do
      visit dog_path(dog)
      expect(page).to_not have_text("Delete #{dog.name}'s Profile")
    end
  end
end
