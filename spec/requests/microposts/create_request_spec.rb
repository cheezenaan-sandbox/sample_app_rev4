# frozen_string_literal: true

require "rails_helper"

RSpec.describe "/microposts", type: :request do
  describe "POST /microposts" do
    subject(:create_request) do
      -> { post microposts_path, params: { micropost: { content: content } } }
    end

    let(:content) { "ありがとう京都アニメーション" }

    context "when not logged in" do
      it { expect(create_request.call).to redirect_to login_path }
    end

    context "when logged in" do
      let(:user) { FactoryBot.create(:user, :activated) }

      before { log_in_as(user) }

      context "when content is empty" do
        let(:content) { "" }

        it "fails to create micropost" do
          expect { create_request.call }.not_to change { Micropost.count }
        end
      end

      context "when content is appropriate" do
        it "succeeds to create micropost" do
          expect { create_request.call }.to change { Micropost.count }.by(1)
          expect(create_request.call).to redirect_to root_path
        end
      end
    end
  end
end
