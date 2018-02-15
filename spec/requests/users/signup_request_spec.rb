# frozen_string_literal: true

require "rails_helper"

RSpec.describe "/users", type: :request do
  describe "GET /signup" do
    subject { response }

    before do
      get signup_path
    end

    it { is_expected.to have_http_status(200) }
  end

  describe "POST /signup" do
    subject(:signup_request) { -> { post signup_path, params: { user: user } } }

    let(:user) do
      {
        name: name,
        email: email,
        password: password,
        password_confirmation: password,
      }
    end

    context "with invalid information" do
      let(:name) { "" }
      let(:email) { "some@foo" }
      let(:password) { "eupho" }

      it { expect(&signup_request).not_to change { User.count } }
      it { expect(signup_request.call).to render_template(:new) }
    end

    context "with valid information" do
      let(:name) { "Kumiko Oumae" }
      let(:email) { "anime-eupho@example.com" }
      let(:password) { "password" }

      it { expect(&signup_request).to change { User.count }.by(1) }
      it { expect(signup_request.call).to redirect_to user_path(assigns(:user)) }

      describe "flash[:success]" do
        subject { flash[:success] }

        before { signup_request.call }
        it { is_expected.not_to be_empty }
      end
    end
  end
end
