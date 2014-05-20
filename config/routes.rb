require 'api_constraints'

Ror::Application.routes.draw do

  scope module: :v1, defaults: { format: :json }, constraints: ApiConstraints.new(version: 1) do
    resources :lists do
      resources :contacts
    end
  end

  scope module: :v2, defaults: { format: :json }, constraints: ApiConstraints.new(version: 2, default: true) do
    resources :lists do
      resources :contacts
    end
  end

end
