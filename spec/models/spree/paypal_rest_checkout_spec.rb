require 'rails_helper'

RSpec.describe Spree::PaypalRestCheckout, type: :model do
  
  describe Spree::PaypalRestCheckout do
    let(:paypal_rest_checkout){create(:spree_paypal_rest_checkout)}

    context 'associations' do 
      it{ is_expected.to have_many :payments }
    end
  end
end