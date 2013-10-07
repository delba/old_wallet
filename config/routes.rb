Wallet::Application.routes.draw do
  root 'dashboard#index'

  controller :dashboard do
    get 'connect'
    get 'callback'
  end
end
