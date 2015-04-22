module QueueClassicAdmin
  class Engine < ::Rails::Engine
    isolate_namespace QueueClassicAdmin

    initializer :append_migrations do |app|
      unless app.root.to_s.match root.to_s
        config.paths["db/migrate"].expanded.each do |expanded_path|
          app.config.paths["db/migrate"] << expanded_path
        end
      end
    end

    initializer :assets do
      Rails.application.config.assets.paths << QueueClassicAdmin::Engine.root.join('vendor', 'assets', 'stylesheets', 'qc-admin-bootstrap')
    end

  end
end
