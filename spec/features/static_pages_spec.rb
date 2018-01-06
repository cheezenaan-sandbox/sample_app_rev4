# frozen_string_literal: true

require "rails_helper"

RSpec.feature "StaticPages", type: :feature do
  feature "Home" do
    before do
      visit static_pages_home_url
    end

    scenario "shows title" do
      expect(page).to have_title "Home | Ruby on Rails Tutorial Sample App"
    end
  end

  feature "Help" do
    before do
      visit static_pages_help_url
    end

    scenario "shows title" do
      expect(page).to have_title "Help | Ruby on Rails Tutorial Sample App"
    end
  end

  feature "About" do
    before do
      visit static_pages_about_url
    end

    scenario "shows title" do
      expect(page).to have_title "About | Ruby on Rails Tutorial Sample App"
    end
  end
end
