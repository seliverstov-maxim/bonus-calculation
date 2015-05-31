Rails.application.routes.draw do
  scope module: :web do
    root 'bonus_calculations#new'
    resource :bonus_calculation, only: [:new, :create]
  end
end
