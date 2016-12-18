module Spree
  class Gateway::PaypalRestBase < Gateway
    include PayPal::SDK::REST
    include PayPal::SDK::Core::Logging

    preference :server,           :select, default: 'sandbox'
    preference :client_id,        :string
    preference :client_secret,    :string

    def provider_class
      PayPal::SDK::REST
    end

    def payment_source_class
      PayPal::SDK::REST::DataTypes::Payment
    end

    def provider
      provider_class.set_config(
        mode: preferred_server,
        client_id: preferred_client_id,
        client_secret: preferred_client_secret
      )
    end

  end
end
