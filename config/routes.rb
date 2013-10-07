Wallet::Application.routes.draw do
  root 'dashboard#index'

  controller :stripe do
    get 'connect'
    get 'callback'
  end
end
