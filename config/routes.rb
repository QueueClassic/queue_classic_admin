QueueClassicAdmin::Engine.routes.draw do
  resources :queue_classic_later_jobs
  resources :queue_classic_jobs

  root to: "queue_classic_jobs#index"
end
