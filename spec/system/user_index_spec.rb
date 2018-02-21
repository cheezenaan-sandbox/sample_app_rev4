# frozen_string_literal: true

require "rails_helper"

RSpec.describe "User index", type: :system do
  subject { page }

  context "when not logged in" do
    before { visit users_path }

    it { is_expected.to have_current_path login_path }
  end

  context "when loggged in as an existing user" do
    let(:user_count) { 30 }

    before do
      FactoryBot.create_list(:user, user_count, :dummy)
    end

    context "as an admin" do
      let(:admin) { FactoryBot.create(:user, :admin) }

      before { log_in_as(admin) }

      it "show user list with pagination" do
        visit users_path
        expect(page).to have_current_path users_path
        expect(page).to have_selector ".pagination"
        expect(all("ul.users li").size).to eq user_count
        expect(page).to have_link "Delete"

        (1..user_count).each do |n|
          expect(page).to have_link "User #{n}"
        end
      end
    end

    context "as a non-admin" do
      let(:non_admin) do
        FactoryBot.create(
          :user,
          name: "Asuka Tanaka",
          email: "anime2@example.com",
        )
      end

      before { log_in_as(non_admin) }

      it "show user list without delete link" do
        visit users_path
        expect(page).not_to have_link "Delete"
      end
    end
  end
end
