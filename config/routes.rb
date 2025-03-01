Rails.application.routes.draw do
  get "password_resets/create"
  get "password_resets/edit"
  get "password_resets/update"
  root "static_pages#top"
  resources :users, only: %i[new create]
  resources :videos, only: %i[index new create show destroy] do
    resources :comments, only: %i[create edit destroy update], shallow: true
    collection do
      get :bookmarks
    end
  end
  resources :bookmarks, only: %i[create destroy]
  resources :password_resets, only: %i[create new edit update]

  get "login", to: "user_sessions#new"
  post "login", to: "user_sessions#create"
  delete "logout", to: "user_sessions#destroy"

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
