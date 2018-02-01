# frozen_string_literal: true

require "rails_helper"

RSpec.describe UsersHelper do
  describe "gravatar_for" do
    subject { gravatar_for(user) }

    context "when user is nil" do
      let(:user) { nil }

      it { is_expected.to eq nil }
    end

    context "when user is present" do
      let(:user) do
        User.new(name: "Kumiko Oumae", email: email,
                 password: "euphonium", password_confirmation: "euphonium")
      end

      context "email is blank" do
        let(:email) { "" }

        it { is_expected.to eq nil }
      end

      context "email is present" do
        let(:email) { "anime-eupho@example.com" }
        let(:default_size) { 80 }

        it { is_expected.to include user.name }
        it { is_expected.to include Digest::MD5.hexdigest(user.email) }
        it { is_expected.to include "s=#{default_size}" }
      end

      context "when size is specified" do
        subject { gravatar_for(user, size: size) }

        let(:email) { "anime-eupho@example.com" }
        let(:size) { 334 }

        it { is_expected.to include "s=#{size}" }
      end
    end
  end
end
