# frozen_string_literal: true

require "rails_helper"

RSpec.describe Relationship, type: :model do
  subject { FactoryBot.build(:relationship, follower_id: follower_id, followed_id: followed_id) }
  let(:follower_id) { FactoryBot.create(:user, :kumiko, :activated).id }
  let(:followed_id) { FactoryBot.create(:user, :asuka, :activated).id }

  context "when follower_id is blank" do
    let(:follower_id) { nil }
    it { is_expected.not_to be_valid }
  end

  context "when followed_id is blank" do
    let(:followed_id) { nil }
    it { is_expected.not_to be_valid }
  end

  context "both follower_id and followed_id is present" do
    it { is_expected.to be_valid }
  end
end
