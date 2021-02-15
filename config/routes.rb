Rails.application.routes.draw do
  
  
  resources :materials
  get 'readers/index' 
  get 'readers/show'
  #resources :readers
  #resources :materials
  resources :texts
  devise_for :admins
  devise_for :readers
devise_scope :reader do
  get '/readers/sign_out' => 'devise/sessions#destroy'
end
devise_scope :admin do
  get '/admins/sign_out' => 'devise/sessions#destroy'
end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "main#index"
end
