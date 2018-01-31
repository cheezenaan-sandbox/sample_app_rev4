# frozen_string_literal: true

require "rails_helper"

RSpec.describe User, type: :model do
  # TODO: Introduce factory_bot
  let(:user) do
    User.new(name: name, email: email,
             password: password, password_confirmation: password)
  end
  subject { user }

  describe "#name" do
    let(:email) { "anime-eupho@example.com" }
    let(:password) { "euphonium" }

    context "when name is moderate" do
      let(:name) { "Kumiko Oumae" }

      it { is_expected.to be_valid }
      its(:name) { is_expected.to eq "Kumiko Oumae" }
    end

    context "when name is blank" do
      let(:name) { "" }

      it { is_expected.to be_invalid }
    end

    context "when name is too long" do
      let(:name) { "a" * 51 }
      it { is_expected.to be_invalid }
    end
  end

  describe "#email" do
    let(:name) { "Kumiko Oumae" }
    let(:password) { "euphonium" }

    context "when email is moderate" do
      let(:email) { "anime-eupho@example.com" }
      it { is_expected.to be_valid }
      its(:email) { is_expected.to eq "anime-eupho@example.com" }
    end

    context "when email is blank" do
      let(:email) { "" }
      it { is_expected.to be_invalid }
    end

    context "when email is too long" do
      let(:email) { "#{'a' * 244}@example.com" }
      it { is_expected.to be_invalid }
    end

    context "when email format is invalid" do
      %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com foo@bar..baz.com].each do |invalid_address|
        let(:email) { invalid_address }
        it { is_expected.to be_invalid }
      end
    end

    context "when email format is valid" do
      %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn].each do |valid_address|
        let(:email) { valid_address }
        it { is_expected.to be_valid }
      end
    end

    context "when email is duplicated" do
      let(:email) { "anime-eupho@example.com" }
      before do
        user_with_duplicated_email = user.dup
        user_with_duplicated_email.email = user.email.upcase
        user_with_duplicated_email.save
      end

      it { is_expected.to be_invalid }
    end

    context "when email contains upcase letters" do
      let(:email) { "ANIME-EUPHO@example.com" }
      before do
        user.email = email
        user.save
      end

      its(:email) { is_expected.to eq email.downcase }
    end
  end

  describe "#password" do
    let(:name) { "Kumiko Oumae" }
    let(:email) { "anime-eupho@example.com" }

    context "when password is blank" do
      let(:password) { " " * 6 }

      it { is_expected.to be_invalid }
    end

    context "when password is less than minimum length" do
      let(:password) { "a" * 5 }

      it { is_expected.to be_invalid }
    end
  end
end
