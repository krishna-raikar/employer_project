Rails.application.routes.draw do


  root 'employers#index'
  resources :employers do
    member do
      get 'reset_password' => "employers#reset_password"
    end

    collection do
      get 'edit_password' => "employers#edit_password"
    end
  end

end
