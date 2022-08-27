Rails.application.routes.draw do
  Rails.application.routes.draw do
    root "bitcoins#index"
    resources :bitcoins
  end
end
