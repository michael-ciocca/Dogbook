# frozen_string_literal: true

require "rails_helper"

describe Dog do
  describe "#owner" do
   let(:owner) { FactoryBot.create(:user) }
   let!(:dog) { FactoryBot.create(:dog, owner: owner) }

    it "can relate a user as an owner" do
      expect(dog.owner).to eq owner
    end

    context "without an owner" do
      let(:owner) { nil }

      it "is valid" do
        expect(dog).to be_valid
      end
    end
  end
end
