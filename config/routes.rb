Ror::Application.routes.draw do
  resources :lists do
    resources :contacts
  end
end
