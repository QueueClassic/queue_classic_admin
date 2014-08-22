QueueClassicAdmin::Engine.routes.draw do
  resources :queue_classic_later_jobs do
    collection do
      delete :destroy_all
    end
  end

  resources :queue_classic_jobs do
    collection do
      delete :destroy_all
      put :unlock_all
    end

    member do
      post :unlock
      post :custom
      get :show
    end
  end

  root to: "queue_classic_jobs#index"
end
