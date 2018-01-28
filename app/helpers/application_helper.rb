# frozen_string_literal: true

module ApplicationHelper
  def full_title(page_title = "")
    base_title = "Ruby on Rails Tutorial Sample App"
    page_title.present? ? "#{page_title} | #{base_title}" : base_title
  end

  def frontend_asset_path(path)
    app = Rails.application
    manifest = app.config.assets_manifest
    return unless manifest.fetch(path, false)

    host = app.config.action_controller.asset_host || app.routes.url_helpers.root_path
    Pathname.new(host).join("assets", "frontend", manifest[path])
  end
end
