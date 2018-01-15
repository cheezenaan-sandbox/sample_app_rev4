# frozen_string_literal: true

require "rails_helper"

RSpec.describe "StaticPages", type: :system do
  let(:base_title) { "Ruby on Rails Tutorial Sample App" }
  subject { page }

  describe "Home page" do
    before { visit root_path }

    it { is_expected.to have_title base_title }
  end

  describe "Help page" do
    before { visit help_path }

    it { is_expected.to have_title "Help | #{base_title}" }
  end

  describe "About page" do
    before { visit about_path }

    it { is_expected.to have_title "About | #{base_title}" }
  end

  describe "Contact page" do
    before { visit contact_path }

    it { is_expected.to have_title "Contact | #{base_title}" }
  end
end
