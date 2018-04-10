# frozen_string_literal: true

require "rails_helper"

RSpec.describe Micropost, type: :model do
  # TODO
  subject(:micropost) { Micropost.new(content: content, user_id: user_id) }
  let(:user) { FactoryBot.create(:user) }

  describe "#user_id" do
    let(:content) { "Sound! Euphonium" }

    context "when user_id is blank" do
      let(:user_id) { nil }
      it { is_expected.not_to be_valid }
    end

    context "when user_id is existed user's one" do
      let(:user_id) { user.id }
      it { is_expected.to be_valid }
    end
  end

  describe "#content" do
    let(:user_id) { user.id }

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
