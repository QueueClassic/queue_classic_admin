QueueClassicAdmin::Engine.routes.draw do
  resources :queue_classic_later_jobs do
    collection do
      delete :purge
    end
  end

  resources :queue_classic_jobs do
    collection do
      delete :purge
    end

    member do
      post :unlock
    end
  end

  root to: "queue_classic_jobs#index"
end
