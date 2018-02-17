# frozen_string_literal: true

require "rails_helper"

RSpec.describe "/users/:id/edit", type: :request do
  describe "GET /users/:id/edit" do
    subject { response }

    let(:user) { FactoryBot.create(:user) }

    context "when not logged in" do
      before { get edit_user_path(user) }

      it { is_expected.to redirect_to login_path }
    end

    context "when logged in as a existing user" do
      before do
        log_in_as(user)
        get edit_user_path(user)
      end

      it { is_expected.to have_http_status(200) }
    end
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

    context "when not logged in" do
      let(:name) { "Kousaka Reina" }
      let(:email) { "anime-eupho+test@example.com" }
      let(:password) { "" }

      it { expect(update_request.call).to redirect_to login_path }
    end

    context "when logged in as a existing user" do
      before { log_in_as(user) }

      context "with invalid information" do
        let(:name) { "" }
        let(:email) { "some@foo" }
        let(:password) { "eupho" }

        it "fail to update information" do
          update_request.call

          expect(response.body).to include(I18n.t("errors.messages.invalid"))
          expect(response).to render_template(:edit)
        end
      end

      context "with valid information" do
        let(:name) { "Kousaka Reina" }
        let(:email) { "anime-eupho+test@example.com" }
        let(:password) { "" }

        it "succeed to update information" do
          update_request.call

          expect(response.body).not_to include(I18n.t("error.messages.invalid"))
          expect(response).to redirect_to user_path(user)
        end
      end
    end
  end
end
