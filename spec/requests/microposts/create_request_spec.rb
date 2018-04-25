# frozen_string_literal: true

require "rails_helper"

RSpec.describe "/microposts", type: :request do
  describe "POST /microposts" do
    subject { response }

    before do
      post microposts_path, params: {
        content: "ありがとう京都アニメーション",
      }
    end

    context "when not logged in" do
      it { is_expected.to redirect_to login_path }
    end
  end
end
