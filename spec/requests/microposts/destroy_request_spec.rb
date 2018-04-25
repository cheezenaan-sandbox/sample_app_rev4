# frozen_string_literal: true

require "rails_helper"

RSpec.describe "/micropost", type: :request do
  describe "DELETE /micropost/:id" do
    subject { response }

    let(:user) { FactoryBot.create(:user, :activated, :with_microposts) }
    let(:micropost) { user.microposts.first}

    before do
      delete micropost_path(micropost)
    end

    context "when not logged in" do
      it { is_expected.to redirect_to login_path }
    end
  end
end
