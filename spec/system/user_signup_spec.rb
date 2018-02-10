# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Signup", type: :system do
  subject { page }

  let(:name) { "" }
  let(:email) { "" }
  let(:password) { "" }

  before do
    visit signup_path
    fill_in "Name", with: name
    fill_in "Email", with: email
    fill_in "Password", with: password
    fill_in "Confirmation", with: password
    click_button "Create my account"
  end

  it { is_expected.to have_selector "form[action='/signup']" }

  context "when filling invalid information" do
    let(:name) { "" }
    let(:email) { "invalid@email" }
    let(:password) { "invalid" }

    it "fails signup" do
      expect(page).to have_selector ".alert-danger"
      expect(page).to have_selector ".field_with_errors"
    end
  end

  context "when filling valid information" do
    let(:name) { "Kumiko Oumae" }
    let(:email) { "anime-eupho@example.com" }
    let(:password) { "euphonium" }

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
