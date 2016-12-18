module Spree
  class Gateway::PaypalExpress < Gateway::PaypalRestBase
    include Gateway::PaypalWebProfile
    include Gateway::PaypalPayment

    preference :brand_name,         :string
    preference :allow_note,         :boolean, default: false
    preference :no_shipping,        :boolean, default: true
    preference :address_override,   :integer, default: 1
    preference :landing_page_type,  :string,  default:'billing'
    preference :temporary,          :boolean, default: true
    preference :locale_code,        :string,  default: 'US'
    preference :profile_name,       :string
    preference :logo_url,           :string, default: 'https://www.paypalobjects.com/webstatic/en_US/i/btn/png/blue-rect-paypal-60px.png'

    alias_method :purchase, :authorize

    def source_required?
      true
    end

    def auto_capture?
      true
    end

    def method_type
      'paypal_express'
    end

    def request_payment(order)
      provider
      payment(order, first_or_new(profile_options).id)
    end

    def purchase(amount, source, options)
      response = payment_source_class.find(source.transaction_id)
      source.update(state: response.state)
      case response.state
      when 'created'
        ActiveMerchant::Billing::Response.new(true, 'success', {}, {})
      when 'failed'
        ActiveMerchant::Billing::Response.new(true, 'failed', {}, {})
      end
    end

    def refund(order)
      # TODO
    end

    def profile_options
      {
        profile_name: preferred_profile_name,
        brand_name: preferred_brand_name,
        allow_note: preferred_allow_note,
        no_shipping: preferred_no_shipping,
        locale_code: preferred_locale_code,
        address_override: preferred_address_override,
        landing_page_type: preferred_landing_page_type,
        temporary: preferred_temporary
      }
    end

  end
end