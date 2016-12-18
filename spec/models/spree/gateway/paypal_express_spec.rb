require 'rails_helper'
describe Spree::Gateway::PaypalExpress do
  let(:gateway) { described_class.create!(name: 'PaypalExpress') }

  context '.provider_class' do
    it 'is a Paypal gateway' do
      expect(gateway.provider_class).to eq PayPal::SDK::REST
    end
  end

  context '.payment_source_class' do
    it 'is a Paypal Payment Object' do
      expect(gateway.payment_source_class).to eq PayPal::SDK::REST::DataTypes::Payment
    end
  end

  context '.provider' do
    it 'is sets Paypal configuration' do
      expect(gateway.provider).to be_an_instance_of PayPal::SDK::REST::API
    end
  end

  context '.source_required?' do
    it 'is set to true' do
      expect(gateway.source_required?).to eq true
    end
  end

  context '.auto_capture?' do
    it 'is set to true' do
      expect(gateway.auto_capture?).to eq true
    end
  end

  context '.method_type' do
    it 'is paypal_express' do
      expect(gateway.method_type).to eq 'paypal_express'
    end
  end

  context '.profile_options' do
    it 'is an Array of preferences' do
      expect(gateway.profile_options).to be_a(Hash)
    end
  end

end