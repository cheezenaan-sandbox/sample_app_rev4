# frozen_string_literal: true

require "rails_helper"

RSpec.describe "/users/:id/edit", type: :request do
  describe "GET /users/:id/edit" do
    subject { response }

    let(:user) { FactoryBot.create(:user) }

    before do
      get edit_user_path(user)
    end

    it { is_expected.to have_http_status(200) }
  end

  describe "PATCH /users/:id" do
    subject(:update_request) { -> { patch user_path(user), params: params } }

    let(:user) { FactoryBot.create(:user) }
    let(:params) do
      {
        id: user.id,
        user: {
          name: name,
          email: email,
          password: password,
          password_confirmation: password,
        },
      }
    end

    context "with invalid information" do
      let(:name) { "" }
      let(:email) { "some@foo" }
      let(:password) { "eupho" }

      it "fails update" do
        update_request.call
        expect(response.body).to include(I18n.t("errors.messages.invalid"))
        expect(response).to render_template(:edit)
      end
    end

    context "with valid information" do
      let(:name) { "Kumiko Oumae" }
      let(:email) { "anime-eupho@example.com" }
      let(:password) { "password" }

      it "TODO: implement later"
    end
  end
end
