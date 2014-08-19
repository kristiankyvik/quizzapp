Rails.application.routes.draw do
  devise_for :users, path_names: {sign_in: "login", sign_out: "logout"}
    resources :users do
    resources :quizzes do
      resources :questions do
        resources :options
      end
    end
  end
end
