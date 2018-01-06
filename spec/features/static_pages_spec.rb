# frozen_string_literal: true

require "rails_helper"

RSpec.feature "StaticPages", type: :feature do
  feature "Home" do
    before do
      visit static_pages_home_url
    end

    # may not be necessary in feature spec: it should be in request spec.
    scenario "returns status code 200" do
      expect(page).to have_http_status(:success)
    end
  end

  feature "Help" do
    before do
      visit static_pages_help_url
    end

    # may not be necessary in feature spec: it should be in request spec.
    scenario "returns status code 200" do
      expect(page).to have_http_status(:success)
    end
  end

  feature "About" do
    before do
      visit static_pages_about_url
    end

    # may not be necessary in feature spec: it should be in request spec.
    scenario "returns status code 200" do
      expect(page).to have_http_status(:success)
    end
  end
end
