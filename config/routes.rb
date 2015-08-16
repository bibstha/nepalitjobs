Rails.application.routes.draw do
  resources :categories, only: :show

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

  scope "/admin" do
    resources :jobs, only: [:show, :destroy], controller: "admin", as: "admin_jobs" do
      post :publish
      post :unpublish
      post :expire
      post :unexpire
    end
    get "/", to: redirect("admin/list_jobs")
  end

  root "jobs#index"
end
