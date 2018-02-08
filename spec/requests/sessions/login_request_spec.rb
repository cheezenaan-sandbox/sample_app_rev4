# frozen_string_literal: true

require "rails_helper"

RSpec.describe "/login", type: :request do
  include SessionsHelper

  describe "GET /login" do
    subject { response }

    before do
      get login_path
    end

    it { is_expected.to have_http_status(200) }
    it { is_expected.to render_template(:new) }
  end

  describe "POST /login" do
    subject(:login_request) { -> { post login_path, params: { session: session } } }

    let(:session) do
      {
        email: email,
        password: password,
      }
    end

    context "with invalid information" do
      let(:email) { "invalid_email" }
      let(:password) { "invalid" }

      it { expect(login_request.call).to render_template(:new) }
    end

    context "with valid information" do
      let(:user) { FactoryBot.create(:user) }
      let(:email) { user.email }
      let(:password) { user.password }

      before do
        user.reload
        login_request.call
      end

      it { is_expected.to redirect_to user_path(user) }
    end
  end

  describe "DELETE /logout" do
    it "is a pending example"
  end
end
