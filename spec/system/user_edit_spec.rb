# frozen_string_literal: true

require "rails_helper"

RSpec.describe "User edit", type: :system do
  subject { page }

  let(:user) { FactoryBot.create(:user) }

  before do
    visit edit_user_path(user)
  end

  context "when filling invalid information" do
    it "TODO: implement later"
  end

  context "when filling valid information" do
    it "TODO: implement later"
  end
end
