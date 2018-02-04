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
    it "is a pending example"
  end

  describe "DELETE /logout" do
    it "is a pending example"
  end
end
