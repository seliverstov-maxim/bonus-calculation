Rails.application.routes.draw do
  scope module: :web do
    root 'sales/bonus_calculations#new'
    namespace :sales do
      resource :bonus_calculation, only: [:new, :create]
    end
    namespace :pm do
      resource :bonus_calculation, only: [:new, :create]
    end
  end
end
