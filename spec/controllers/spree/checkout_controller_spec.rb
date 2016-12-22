require 'rails_helper'
describe Spree::CheckoutController, type: :controller do 
  let(:token) {'some_token'}
  let(:user)  {stub_model(Spree::LegacyUser)}
  let(:order) {FactoryGirl.create(:order_with_line_items)}


  context '#paypal_express_return' do 
    specify do
    end
  end

  context '#paypal_express' do 
    specify do
    end
  end

  context '#paypal_express_cancel' do 
    specify do
    end
  end
  
  context '#paypal_rest_hook', js: true do 
    specify do 
    end
  end

end