require 'rails_helper'

RSpec.describe DogsController, type: :controller do
  describe '#index' do
    it 'displays recent dogs' do
      2.times { create(:dog) }
      get :index
      expect(assigns(:dogs).size).to eq(2)
    end
  end

  context "with matching logged in user" do
    let(:user) { FactoryBot.create(:user) }
    let!(:dog) { FactoryBot.create(:dog, owner: user) }

    before do
      allow(controller).to receive(:current_user).and_return(user)
    end

    describe "#edit" do
      it "allows the user to edit the dog" do
        patch :update, params: { dog: { name: "fluffy" }, id: dog.id }

        expect(dog.reload.name).to eq "fluffy"
      end
    end

    describe "#destroy" do
      it "allows the user to edit the dog" do
        delete :destroy, params: { id: dog.id }

        expect { dog.reload }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  context "without a logged in user" do
    let(:user) { FactoryBot.create(:user) }
    let!(:dog) { FactoryBot.create(:dog, owner: user) }

    before do
      allow(controller).to receive(:current_user).and_return(nil)
    end

    describe "#edit" do
      it "does not allow a dog to be edited" do
        expect {
          patch :update, params: { dog: { name: "fluffy" }, id: dog.id }
        }.not_to change { dog.reload }
      end
    end

    describe "#destroy" do
      it "does not allow a dog to be destroyed" do
        expect {
          delete :destroy, params: { id: dog.id }
        }.not_to change { dog.reload }
      end
    end
  end
end
