# frozen_string_literal: true

require "rails_helper"

RSpec.describe "User profile", type: :system do
  subject { page }

  let(:user) { FactoryBot.create(:user, :kumiko, :activated, :with_microposts) }

  context "when access to profile page" do
    before do
      visit user_path(user)
    end

    it "show profile with microposts" do
      expect(page).to have_title full_title(user.name)
      expect(page).to have_selector "h1", text: user.name
      expect(page).to have_selector "h1>img.gravatar"
      expect(page).to have_selector ".pagination"
    end
  end
end
