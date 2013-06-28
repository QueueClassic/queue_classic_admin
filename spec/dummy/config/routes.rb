Rails.application.routes.draw do
  mount QueueClassicAdmin::Engine => "/queue_classic_admin"
end
