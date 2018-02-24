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

  context "when filling invalid information" do
    let(:name) { "" }
    let(:email) { "invalid@email" }
    let(:password) { "invalid" }

    it "fail to signup" do
      expect(page).to have_selector ".alert-danger"
      expect(page).to have_selector ".field_with_errors"
    end
  end

  context "when filling valid information" do
    let(:user) { FactoryBot.build(:user) }
    let(:name) { user.name }
    let(:email) { user.email }
    let(:password) { user.password }

    # TODO: Add case for account activation
    xit "succeed to signup and show user profile page" do
      expect(page).to have_content user.name
      expect(page).not_to have_selector ".alert-danger"
      expect(page).not_to have_selector ".field_with_errors"
      expect(page).not_to have_link "Log in", href: login_path

      click_link "Account"
      expect(page).to have_link "Log out", href: logout_path
    end
  end
end
