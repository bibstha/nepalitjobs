Rails.application.routes.draw do
  resources :jobs do
    member do
      get :preview
      post :complete
    end
  end
end
