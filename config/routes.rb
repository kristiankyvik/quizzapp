Rails.application.routes.draw do
  devise_for :users, path_names: {sign_in: "login", sign_out: "logout"}
  root 'welcome#home'
  resources :games do
    collection do
      get :sign_in
      get :play
      get :server
      get :client
      post :client
      post :start
    end
  end
    resources :users do
    resources :quizzes do
      resources :questions do
        resources :options
      end
    end
  end
end
