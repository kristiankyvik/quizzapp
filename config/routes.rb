Rails.application.routes.draw do
  devise_for :users, path_names: {sign_in: "login", sign_out: "logout"}
  root 'welcome#home'
  resources :games do
    collection do
      get :sign_in
      get :play
      get :server
      get :client
      post :signup
      post :client
      post :start
      post :answer
      post :answersheet
      post :next_question
      post :refresh
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
