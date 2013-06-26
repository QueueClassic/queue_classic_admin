QueueClassicAdmin::Engine.routes.draw do
  resources :queue_classic_jobs do
    collection do
      get :scheduled
    end
  end
  root to: "queue_classic_jobs#index"
end
