# frozen_string_literal: true

require "rails_helper"

RSpec.describe SessionHelper do
  describe "current_user" do
    subject { current_user }

    let(:user) { FactoryBot.create(:user, :activated) }

    before { remember(user) }

    context "when session is nil" do
      it { is_expected.to eq user }
    end

    context "when remember_digest is wrong" do
      before do
        user.update_attribute(:remember_digest, SecureDigest.digest(SecureToken.create))
      end

      it { is_expected.to eq nil }
    end
  end
end
