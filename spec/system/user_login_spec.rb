# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Login", type: :system do
  subject { page }

  let(:error_message) { "Invalid email/password combination" }

  before { visit login_path }

  context "when filling invalid information" do
    before do
      fill_in "Email", with: "anime-eupho@invalid"
      fill_in "Password", with: "invalid"
      click_button "Login"
    end

    it { is_expected.to have_content error_message }

    context "when jumping to another page" do
      before { visit root_path }

      it { is_expected.not_to have_content error_message }
    end
  end

  context "when filling valid information" do
    let(:user) { FactoryBot.create(:user) }

    before do
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      click_button "Login"
    end

    it "succeeds login and redirect to user page" do
      expect(page).to have_current_path %r{users\/(\d+)}
      expect(page).not_to have_link "Log in", href: login_path
      expect(page).to have_link "Users"
      expect(page).to have_content "Account"

      click_link "Account"
      expect(page).to have_link "Log out", href: logout_path
    end

    it "logout and redirect_to Home page" do
      click_link "Account"
      click_link "Log out"

      expect(page).to have_current_path root_path
      expect(page).to have_link "Log in", href: login_path
      expect(page).not_to have_link "Users"
      expect(page).not_to have_content "Account"
    end
  end
end
