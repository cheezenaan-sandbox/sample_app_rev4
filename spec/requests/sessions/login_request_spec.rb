# frozen_string_literal: true

require "rails_helper"

RSpec.describe "/login", type: :request do
  describe "GET /login" do
    subject { response }

    before do
      get login_path
    end

    it { is_expected.to have_http_status(200) }
    it { is_expected.to render_template(:new) }
  end

  describe "POST /login" do
    subject { response }

    let(:user) { FactoryBot.create(:user, :activated) }

    context "with invalid information" do
      let(:invalid_user) { FactoryBot.build(:user, email: email, password: password) }
      let(:email) { "invalid_email" }
      let(:password) { "invalid" }

      before do
        log_in_as(invalid_user)
      end

      it { is_expected.to render_template(:new) }
    end

    context "when account hasn't activated yet" do
      let(:user) { FactoryBot.create(:user) }
      let(:warning) { "Account not activated." }

      before { log_in_as(user) }

      it { is_expected.to redirect_to root_path }
    end

    context "with valid information" do
      before do
        log_in_as(user, remember_me: remember_me)
      end

      context "with remembering" do
        let(:remember_me) { "1" }

        it "login succeeds and remember_token stores in cookies" do
          expect(response).to redirect_to user_path(user)
          expect(cookies[:remember_token]).not_to eq nil
        end
      end

      context "without remembering" do
        let(:remember_me) { "0" }

        it "login succeeds and remember_token removes from cookies" do
          expect(response).to redirect_to user_path(user)
          expect(cookies[:remember_token]).to eq nil
        end
      end
    end
  end
end
