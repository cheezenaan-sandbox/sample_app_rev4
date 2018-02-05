# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Login page", type: :system do
  subject { page }

  before { visit login_path }

  context "when filling invalid information" do
    before do
      fill_in "Email", with: "anime-eupho@invalid"
      fill_in "Password", with: "invalid"
      click_button "Login"
    end
    let(:error_message) { "Invalid email/password combination" }

    it { is_expected.to have_content error_message }

    context "when jumping to another page" do
      before { visit root_path }

      it { is_expected.not_to have_content error_message }
    end
  end
end
