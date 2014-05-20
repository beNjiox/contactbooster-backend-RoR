require 'api_constraints'

Ror::Application.routes.draw do
  scope defaults: { format: :json }, constraints: ApiConstraints.new(version: 1, default: true) do
    resources :lists do
      resources :contacts
    end
  end
end
