# frozen_string_literal: true

require "rails_helper"

RSpec.describe "/signup", type: :request do
  describe "GET /signup" do
    subject { response }

    before do
      get signup_path
    end

    it { is_expected.to have_http_status(200) }
  end

  describe "POST /signup" do
    subject { response }

    let(:user) do
      {
        name: name,
        email: email,
        password: password,
        password_confirmation: password,
      }
    end

    before do
      post signup_path, params: { user: user }
    end

    context "with invalid information" do
      let(:name) { "" }
      let(:email) { "some@foo" }
      let(:password) { "eupho" }

      it "fail to signup" do
        expect(response.body).to include(I18n.t("errors.messages.invalid"))
        expect(response).to render_template(:new)
      end
    end

    context "with valid information" do
      let(:name) { "Kumiko Oumae" }
      let(:email) { "anime-eupho@example.com" }
      let(:password) { "password" }

      it "succeed to signup" do
        expect(response.body).not_to include(I18n.t("error.messages.invalid"))
        expect(response).to have_http_status(302)
      end
    end
  end
end
