# frozen_string_literal: true

module ApplicationHelper
  def full_title(page_title = "")
    base_title = "Ruby on Rails Tutorial Sample App"
    page_title.present? ? "#{page_title} | #{base_title}" : base_title
  end

  def frontend_asset_path(path)
    manifest = Rails.application.config.assets_manifest
    return unless manifest.fetch(path, false)

    routes = Rails.application.routes.url_helpers
    host = Rails.application.config.action_controller.asset_host || routes.root_path

    Pathname.new(host).join("assets", manifest[path])
  end
end
