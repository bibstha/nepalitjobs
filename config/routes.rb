Rails.application.routes.draw do
  resources :jobs, except: [:destroy] do
    get :search, on: :collection
    member do
      get :preview
      post :complete
    end
  end

  namespace :admin do
    get :list_jobs
  end

  scope '/admin' do
    resources :jobs, only: [:destroy], controller: "admin", as: "admin_jobs" do
      post :publish
      post :unpublish
      post :expire
      post :unexpire
    end
  end

  root "jobs#index"
end
