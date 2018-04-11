# frozen_string_literal: true

require "rails_helper"

RSpec.describe Micropost, type: :model do
  let(:user) { FactoryBot.create(:user) }
  subject(:micropost) { user.microposts.build(content: content) }

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
end
