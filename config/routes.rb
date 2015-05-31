Rails.application.routes.draw do
  scope module: :web do
    resources :bonuses
    resource :bonus_calculation
  end
end
