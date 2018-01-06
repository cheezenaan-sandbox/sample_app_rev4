# frozen_string_literal: true

require "rails_helper"

RSpec.feature "StaticPages", type: :feature do
  feature "Home" do
    before do
      visit static_pages_home_url
    end
  end

  feature "Help" do
    before do
      visit static_pages_help_url
    end
  end

  feature "About" do
    before do
      visit static_pages_about_url
    end
  end
end
