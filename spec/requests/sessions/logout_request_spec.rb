# frozen_string_literal: true

require "rails_helper"

RSpec.describe "/logout", type: :request do
  describe "DELETE /logout" do
    subject(:logout_request) { -> { delete logout_path } }

    it { expect(logout_request.call).to redirect_to root_url }
  end
end
