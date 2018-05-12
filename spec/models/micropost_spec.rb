# frozen_string_literal: true

require "rails_helper"

RSpec.describe Micropost, type: :model do
  subject(:micropost) { user.microposts.build(content: content) }

  let(:user) { FactoryBot.create(:user, :kumiko) }

  describe "#user_id" do
    let(:content) { "Sound! Euphonium" }

    context "when user_id is blank" do
      before do
        micropost.user_id = nil
      end

      it { is_expected.not_to be_valid }
    end

    context "when user_id is existed user's one" do
      it { is_expected.to be_valid }
    end
  end

  describe "#content" do
    context "when content is blank" do
      let(:content) { " " }

      it { is_expected.to be_invalid }
    end

    context "when content is more than 140 characters" do
      let(:content) { "a" * 141 }

      it { is_expected.to be_invalid }
    end
  end

  describe ".recent scope" do
    let(:micropost_count) { 10 }
    let(:most_recent) { FactoryBot.create(:micropost, :most_recent, user: user) }

    before do
      FactoryBot.create_list(:micropost, micropost_count, :dummy, user: user)
      most_recent.reload
    end

    it "is most recent first" do
      expect(Micropost.recent.first).to eq most_recent
    end
  end
end
