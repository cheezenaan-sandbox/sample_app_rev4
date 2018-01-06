# frozen_string_literal: true

require "rails_helper"

RSpec.feature "StaticPages", type: :feature do
  let(:base_title) { "Ruby on Rails Tutorial Sample App" }

  feature "Home" do
    before do
      visit static_pages_home_url
    end

    scenario "shows title" do
      expect(page).to have_title "Home | #{base_title}"
    end
  end

  feature "Help" do
    before do
      visit static_pages_help_url
    end

    scenario "shows title" do
      expect(page).to have_title "Help | #{base_title}"
    end
  end

  feature "About" do
    before do
      visit static_pages_about_url
    end

    scenario "shows title" do
      expect(page).to have_title "About | #{base_title}"
    end
  end
end
