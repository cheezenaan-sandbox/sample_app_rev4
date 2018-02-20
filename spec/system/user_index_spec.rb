# frozen_string_literal: true

require "rails_helper"

RSpec.describe "User index", type: :system do
  subject { page }

  context "when not logged in" do
    before { visit users_path }

    it { is_expected.to have_current_path login_path }
  end

  context "when logged in" do
    let(:user) { FactoryBot.create(:user) }
    let(:user_count) { 30 }

    before do
      FactoryBot.create_list(:user, user_count, :dummy)
      log_in_as(user)
      visit users_path
    end

    it "show user list with pagination" do
      expect(page).to have_current_path users_path
      expect(page).to have_selector ".pagination"
      expect(all("ul.users li").size).to eq user_count

      (1..user_count).each do |n|
        expect(page).to have_link "User #{n}"
      end
    end
  end
end
