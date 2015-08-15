Rails.application.routes.draw do
  resources :jobs do
    get :preview, on: :member
  end
end
