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

    # Force auto_capture
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
      payment = payment_source_class.find(source.payment_id)
      executed_payment = payment.execute(payer_id: source.payer_id)
      sale_id = payment.transactions.first.related_resources.first.sale.id
      source.update(state: payment.state, sale_id: sale_id)
      byebug
      if executed_payment
        ActiveMerchant::Billing::Response.new(true, 'success', payment.to_hash, options)
      else
        ActiveMerchant::Billing::Response.new(false, 'failed', payment.to_hash, options)
      end
    end

    def refund(amount, source, options)
      byebug
    end

    def cancel(spree_payment_id)
      spree_payment = Spree::Payment.find(spree_payment_id)
      payment = payment_source_class.find(spree_payment.source.payment_id)
      sale_id = payment.transactions.first.related_resources.first.sale.id
      sale = PayPal::SDK::REST::Sale.find(sale_id)
      refund = sale.refund_request({
        amount:{
          total: spree_payment.amount,
          currency: spree_payment.currency
        }
      })
      if refund.success?
        ActiveMerchant::Billing::Response.new(true, 'success', refund.to_hash, {})
      else
        ActiveMerchant::Billing::Response.new(false, 'failed', payment.to_hash, options)
      end
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