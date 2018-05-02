# frozen_string_literal: true

require "rails_helper"

RSpec.describe "/micropost", type: :request do
  describe "DELETE /micropost/:id" do
    subject(:destroy_request) { -> { delete micropost_path(micropost) } }

    let(:user) { FactoryBot.create(:user, :activated, :with_microposts) }
    let(:micropost) { user.microposts.first }

    context "when not logged in" do
      it { expect(destroy_request.call).to redirect_to login_path }
    end

    context "when deleting other user's micropost" do
      let(:another_user) { FactoryBot.create(:user, :activated, :dummy) }
      let(:micropost) { FactoryBot.create(:micropost, :dummy, user: another_user) }

      before do
        log_in_as(user)
        micropost.reload
      end

      it "fails to delete micropost" do
        expect { destroy_request.call }.not_to change { Micropost.count }
        expect(destroy_request.call).to redirect_to root_path
      end
    end

    context "when deleting user's own micropost" do
      before do
        log_in_as(user)
      end

      it "succeeds to delete micropost" do
        expect { destroy_request.call }.to change { Micropost.count }.by(-1)
        expect(destroy_request.call).to redirect_to root_path
      end
    end
  end
end
