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
    subject(:signup_request) { -> { post signup_path, params: params } }

    let(:params) do
      {
        user: {
          name: name,
          email: email,
          password: password,
          password_confirmation: password,
        },
      }
    end

    before do
      signup_request.call
    end

    context "with invalid information" do
      let(:name) { "" }
      let(:email) { "some@foo" }
      let(:password) { "eupho" }

      it { is_expected.to render_template(:new) }
      it { is_expected.not_to change(User, :count) }
    end
  end
end
