# frozen_string_literal: true

require "rails_helper"

RSpec.describe "/users", type: :request do
  describe "GET /users" do
    subject { response }

    before do
      get users_path
    end

    context "when not logged in" do
      it { is_expected.to redirect_to login_path }
    end
  end
end
