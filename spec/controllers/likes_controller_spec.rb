# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LikesController, type: :controller do
  describe '#toggle' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:dog) { FactoryBot.create(:dog) }

    before do
      allow(controller).to receive(:current_user).and_return(user)
    end

    context "current user does not own dog" do
      context "current user does not already like dog" do
        it 'likes the dog when not already liked' do
          post :toggle, params: { dog_id: dog.id }

          expect(dog.admirers).to include(user)
        end
      end

      context "current user already likes dog" do
        let!(:dog) { FactoryBot.create(:dog, admirers: [user]) }

        it 'unlikes the dog when not already liked' do
          post :toggle, params: { dog_id: dog.id }

          expect(dog.reload.admirers).to_not include(user)
        end
      end
    end
  end
end
