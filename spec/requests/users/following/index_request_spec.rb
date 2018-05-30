# frozen_string_literal: true

require "rails_helper"

RSpec.describe "/users/:id/following", type: :request do
  describe "GET /users/:id/following" do
    subject { get following_user_index_path(user) }

    let(:user) { FactoryBot.create(:user, :kumiko, :activated) }
    let(:another) { FactoryBot.create(:user, :asuka, :activated) }

    context "when not logged in" do
      it { is_expected.to redirect_to login_path }
    end

    context "when logged in" do
      before do
        log_in_as(user)
      end

      it { is_expected.to render_template("users/show_follow") }
    end
  end
end
