# frozen_string_literal: true

require "rails_helper"

RSpec.describe "/relationships", type: :request do
  describe "POST /relationships" do
    subject(:create_request) do
      lambda {
        post relationships_path, params: { followed_id: followed_id }
      }
    end

    let(:user) { FactoryBot.create(:user, :kumiko, :activated) }
    let(:another) { FactoryBot.create(:user, :asuka, :activated) }
    let(:followed_id) { another.id }

    context "when not logged in" do
      it { expect(create_request.call).to redirect_to login_path }
    end

    context "when logged in" do
      before do
        log_in_as user
      end

      context "when already followed" do
        before do
          user.follow(another)
        end

        it "fails to create active relationship" do
          expect { create_request.call }.not_to change { Relationship.count }
        end
      end

      context "when not followed yet" do
        it "succeeds to create active relationship" do
          expect { create_request.call }.to change { Relationship.count }.by(1)
        end
      end
    end
  end
end
