Rails.application.routes.draw do
  root "teams#new"
  post 'teams/:id/acquire_player', to: 'teams#acquire_player', as: 'acquire_player'

  resources :teams, only: [:new, :create, :show] do
    resources :players
    resources :staff_members
  end
  
  resources :teams do
    member do
      get :download_players_pdf
    end
  end

  resources :teams do
    post 'acquire_player', on: :member
  end
  
  resources :teams do
    resources :draw_players, only: [:new, :create]
  end

    

  resources :players, only: [:destroy]
  resources :staff_members, only: [:destroy]
end
