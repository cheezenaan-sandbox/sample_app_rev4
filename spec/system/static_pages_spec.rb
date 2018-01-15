# frozen_string_literal: true

require "rails_helper"

RSpec.describe "StaticPages", type: :system do
  let(:base_title) { "Ruby on Rails Tutorial Sample App" }

  it "Home" do
    visit root_path
    expect(page).to have_title base_title
  end

  it "Help" do
    visit help_path
    expect(page).to have_title "Help | #{base_title}"
  end

  it "About" do
    visit about_path
    expect(page).to have_title "About | #{base_title}"
  end

  it "Contact" do
    visit contact_path
    expect(page).to have_title "Contact | #{base_title}"
  end
end
