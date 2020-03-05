Rails.application.routes.draw do

  resources :clients do
    collection do
      get :parse
    end
  end
  mount_roboto
  resources :users, only: %i[index]
  devise_for :users

  # %w[about services]
  %w[about].each do |name|
    get name =>  "main##{name}", as: name
  end

  resources :notes, path: 'contacts', only: %i[index create destroy new] do
    collection do
      get :list
    end
  end

  resources :projects, path: 'portfolio' do
    resources :containers, except: %i[index show]
  end

  resources :containers, only: %i[] do
    collection do
      post :sort
    end
  end

  root to: 'main#index'
end
