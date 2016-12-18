Spree::Core::Engine.add_routes do
  
  resources :orders do
    resource :checkout, controller:'checkout' do
      member do
        get :paypal_express
        get :paypal_express_cancel
        get :paypal_express_return
      end
    end
  end
  
end
