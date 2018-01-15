# frozen_string_literal: true

require "rails_helper"

RSpec.describe "StaticPages", type: :request do
  describe "GET /" do
    subject { response }

    before do
      get root_path
    end

    it { is_expected.to have_http_status(200) }
    it { is_expected.to render_template(:home) }
  end

  describe "GET /help" do
    subject { response }

    before do
      get help_path
    end

    it { is_expected.to have_http_status(200) }
  end

  describe "GET /about" do
    subject { response }

    before do
      get about_path
    end

    it { is_expected.to have_http_status(200) }
  end

  describe "GET /contact" do
    subject { response }

    before do
      get contact_path
    end

    it { is_expected.to have_http_status(200) }
  end
end
