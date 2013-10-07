Wallet::Application.routes.draw do
  root 'dashboard#index'

  controller :stripe do
    get 'authorize'
    get 'callback'
  end
end
