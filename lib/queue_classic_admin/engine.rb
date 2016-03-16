module QueueClassicAdmin
  class Engine < ::Rails::Engine
    isolate_namespace QueueClassicAdmin

    initializer :assets do
      Rails.application.config.assets.paths << QueueClassicAdmin::Engine.root.join("vendor", "assets", "stylesheets", "qc-admin-bootstrap").to_s
    end
  end
end
