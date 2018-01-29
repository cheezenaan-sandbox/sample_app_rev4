# frozen_string_literal: true

require "rails_helper"

RSpec.describe User, type: :model do
  let(:user) { User.new(name: "Kumiko Oumae", email: "anime-eupho@example.com") }
  subject { user }

  describe "#name" do
    it { is_expected.to be_valid }
    its(:name) { is_expected.to eq "Kumiko Oumae" }
  end

  describe "#email" do
    it { is_expected.to be_valid }
    its(:email) { is_expected.to eq "anime-eupho@example.com" }
  end
end
