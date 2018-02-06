# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Login page", type: :system do
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
    before do
      fill_in "Email", with: "anime-eupho@example.com"
      fill_in "Password", with: "euphonium"
      click_button "Login"
    end

    # TODO: Introduce factory_bot for fixtures
    it "is a pending example"
  end
end
