# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Signup page", type: :system do
  subject { page }

  before { visit signup_path }

  it { is_expected.to have_selector "form[action='/signup']" }

  context "when filling invalid information" do
    before do
      fill_in "Name", with: ""
      fill_in "Email", with: "anime-eupho@invalid"
      fill_in "Password", with: "invalid"
      fill_in "Confirmation", with: "invalid_password"
      click_button "Create my account"
    end

    it "fails signup" do
      expect(page).to have_selector ".alert-danger"
      expect(page).to have_selector ".field_with_errors"
    end
  end

  context "when filling valid information" do
    before do
      fill_in "Name", with: "Kumiko Oumae"
      fill_in "Email", with: "anime-eupho@example.com"
      fill_in "Password", with: "password"
      fill_in "Confirmation", with: "password"
      click_button "Create my account"
    end

    it "succeeds signup and redirect to user page" do
      expect(page).to have_current_path %r{users\/(\d+)}
      expect(page).not_to have_selector ".alert-danger"
      expect(page).not_to have_selector ".field_with_errors"
      expect(page).not_to have_link "Log in", href: login_path

      click_link "Account"
      expect(page).to have_link "Log out", href: logout_path
    end
  end
end
