
# frozen_string_literal: true

require "rails_helper"

RSpec.describe "/users/:id", type: :request do
  describe "DELETE /users/:id" do
    subject(:delete_request) { -> { delete user_path(user) } }

    let(:user) { FactoryBot.create(:user, :dummy) }

    before { user.reload }

    context "when not logged in" do
      it { expect { delete_request.call }.not_to change { User.count } }
    end

    context "when logged in as a non-admin" do
      let(:non_admin) do
        FactoryBot.create(
          :user,
          name: "Asuka Tanaka",
          email: "anime2@example.com",
        )
      end

      before { log_in_as(non_admin) }

      it { expect { delete_request.call }.not_to change { User.count } }
    end

    context "when logged in as an admin" do
      let(:admin) { FactoryBot.create(:user, :admin) }

      before { log_in_as(admin) }

      it { expect { delete_request.call }.to change { User.count }.by(-1) }
    end
  end
end
