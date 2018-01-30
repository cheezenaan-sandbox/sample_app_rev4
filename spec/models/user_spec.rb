# frozen_string_literal: true

require "rails_helper"

RSpec.describe User, type: :model do
  let(:user) { User.new(name: name, email: email) }
  subject { user }

  describe "#name" do
    let(:email) { "anime-eupho@example.com" }

    context "when name is blank" do
      let(:name) { "" }

      it { is_expected.to be_invalid }
    end

    context "when name is present" do
      let(:name) { "Kumiko Oumae" }

      it { is_expected.to be_valid }
      its(:name) { is_expected.to eq "Kumiko Oumae" }
    end
  end

  describe "#email" do
    let(:name) { "Kumiko Oumae" }

    context "when email is blank" do
      let(:email) { "" }
      it { is_expected.to be_invalid }
    end

    context "when email is present" do
      let(:email) { "anime-eupho@example.com" }
      it { is_expected.to be_valid }
      its(:email) { is_expected.to eq "anime-eupho@example.com" }
    end
  end
end
