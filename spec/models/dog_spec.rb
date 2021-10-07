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

  describe "#order_by_likes_in_past_hour" do
   let(:users) { FactoryBot.create_list(:user, 3) }
   let!(:dog) { FactoryBot.create(:dog) }
   let!(:dog2) { FactoryBot.create(:dog) }
   let!(:dog3) {FactoryBot.create(:dog) }

    context "when a like was created within the last hour" do
      before do
        dog.admirers = [users[0], users[1]]
        dog2.admirers = [users[1]]

        time_out_of_range = Time.current - 1.day
        Like.create(dog: dog3, user: users[0], created_at: time_out_of_range)
      end

      it "doesn't include the dog that was liked yesterday" do
        expect(Dog.order_by_likes_in_past_hour).to_not include(dog3)
      end

      it "includes the dogs in the correct order" do
        first, second = Dog.order_by_likes_in_past_hour
        expect(first).to eq dog
        expect(second).to eq dog2
      end
    end
  end
end
