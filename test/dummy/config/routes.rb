Rails.application.routes.draw do
  resources :pages, only: %i(index show)
end
