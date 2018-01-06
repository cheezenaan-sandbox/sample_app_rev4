# frozen_string_literal: true

require "rails_helper"

RSpec.describe "StaticPages", type: :request do
  describe "GET /static_pages/home" do
    subject { response }

    before do
      get static_pages_home_path
    end

    it { is_expected.to have_http_status(200) }
  end

  describe "GET /static_pages/help" do
    subject { response }

    before do
      get static_pages_help_path
    end

    it { is_expected.to have_http_status(200) }
  end

  describe "GET /static_pages/about" do
    subject { response }

    before do
      get static_pages_about_path
    end

    it { is_expected.to have_http_status(200) }
  end
end
