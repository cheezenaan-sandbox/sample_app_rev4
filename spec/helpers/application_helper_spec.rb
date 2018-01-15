# frozen_string_literal: true

require "rails_helper"

RSpec.describe ApplicationHelper do
  describe "full_title" do
    subject { full_title(page_title) }

    context "without page_title" do
      let(:page_title) { "" }

      it { is_expected.to eq "Ruby on Rails Tutorial Sample App" }
    end

    context "with page_title" do
      let(:page_title) { "Sound! Euphonium" }

      it { is_expected.to eq "Sound! Euphonium | Ruby on Rails Tutorial Sample App" }
    end
  end
end
