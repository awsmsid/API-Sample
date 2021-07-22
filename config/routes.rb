Rails.application.routes.draw do

  scope '/api' do

    get 'healthcheck', to: 'application#healthcheck'

    resources :customers  , only: [:index, :create, :update]

    get 'customer', to: 'customers#show'

    resources :bill_payments , only: [:create, :index]
    resources :check_token , only: [:create]
    resources :forgot_password , only: [:create]
    resources :parser , only: [:create]
    resources :receipts , only: [:index, :show, :update, :destroy]
    patch 'receipts_reject/:id', to: 'receipts#receipts_reject'
    resources :reward_services , only: [:index, :create]
    resources :bill_reminders , only: [:index, :create, :update, :destroy]
    resources :manual_processings , only: [:index, :update]
    resources :bill_companies, only: [:create, :index, :update, :destroy]
    resources :utility_types, only: [:create, :index, :update, :destroy]
    resources :won, only: [:create]
    resources :accounts, only: [:create, :index]
    resources :topups, only: [:create, :update]
    resources :transfers, only: [:create]
    resources :topups, only: [:create, :update, :index]
    resources :start_game, only: [:create, :update]
    resources :withdraw, only: [:create, :index]
    resources :transactions, only: [:index]
  end

end
