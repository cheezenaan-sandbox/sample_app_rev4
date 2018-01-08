# frozen_string_literal: true

module ApplicationHelper
  def full_title(page_title = "")
    base_title = "Ruby on Rails Tutorial Sample App"
    page_title.present? ? "#{page_title} | #{base_title}" : base_title
  end
end
