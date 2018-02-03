# frozen_string_literal: true

require "rails_helper"

RSpec.describe "User signup", type: :system do
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

    it { is_expected.to have_selector ".alert-danger" }
    it { is_expected.to have_selector ".field_with_errors" }
  end
end
