# frozen_string_literal: true

require "rails_helper"

RSpec.describe "StaticPages", type: :system do
  subject { page }

  let(:base_title) { "Ruby on Rails Tutorial Sample App" }

  describe "Home page" do
    before { visit root_path }

    it { is_expected.to have_title full_title }
    it { is_expected.to have_link "Home", href: root_path }
    it { is_expected.to have_link "Help", href: help_path }
    it { is_expected.to have_link "About", href: about_path }
    it { is_expected.to have_link "Contact", href: contact_path }
  end

  describe "Help page" do
    before { visit help_path }

    it { is_expected.to have_title full_title("Help") }
  end

  describe "About page" do
    before { visit about_path }

    it { is_expected.to have_title full_title("About") }
  end

  describe "Contact page" do
    before { visit contact_path }

    it { is_expected.to have_title full_title("Contact") }
  end
end
