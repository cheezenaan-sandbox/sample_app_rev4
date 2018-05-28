
# frozen_string_literal: true

require "rails_helper"

RSpec.describe "/relationship", type: :request do
  describe "DELETE /relationship" do
    subject(:destroy_request) do
      lambda {
        delete relationship_path(relationship)
      }
    end

    let(:user) { FactoryBot.create(:user, :kumiko, :activated) }
    let(:another) { FactoryBot.create(:user, :asuka, :activated) }
    let(:relationship) do
      FactoryBot.create(
        :relationship,
        follower_id: user.id,
        followed_id: another.id,
      )
    end

    context "when not logged in" do
      it { expect(destroy_request.call).to redirect_to login_path }
    end

    context "when logged in" do
      before do
        log_in_as user
        relationship.reload
      end

      context "when already followed" do
        it "succeeds to delete active relationship" do
          expect { destroy_request.call }.to change { Relationship.count }.by(-1)
        end
      end

      context "when not followed yet" do
        before do
          user.unfollow(another)
        end

        xit "fails to delete active relationship" do
          expect { destroy_request.call }.not_to change { Relationship.count }
        end
      end
    end
  end
end
