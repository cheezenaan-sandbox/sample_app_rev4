# frozen_string_literal: true

require "rails_helper"

describe "Users", type: :request do
  describe "GET /signup" do
    subject { response }

    before do
      get signup_path
    end

    it { is_expected.to have_http_status(200) }
  end
end
