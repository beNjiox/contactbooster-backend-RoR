Ror::Application.routes.draw do
  scope defaults: { format: :json } do
    resources :lists do
      resources :contacts
    end
  end
end
