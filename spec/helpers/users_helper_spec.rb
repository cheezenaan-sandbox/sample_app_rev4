# frozen_string_literal: true

require "rails_helper"

RSpec.describe UsersHelper do
  describe "gravatar_for" do
    subject { gravatar_for(user) }

    context "when user is nil" do
      let(:user) { nil }

      it { is_expected.to eq nil }
    end

    context "when user.email is blank" do
      let(:user) do
        User.new(name: "Kumiko Oumae", email: "",
                 password: "euphonium", password_confirmation: "euphonium")
      end

      it { is_expected.to eq nil }
    end

    context "when user.email is NOT blank" do
      let(:user) do
        User.new(name: "Kumiko Oumae", email: "anime-eupho@example.com",
                 password: "euphonium", password_confirmation: "euphonium")
      end

      it { is_expected.to include user.name }
      it { is_expected.to include Digest::MD5.hexdigest(user.email) }
    end
  end
end
