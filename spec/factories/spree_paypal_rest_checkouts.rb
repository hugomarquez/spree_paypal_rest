FactoryGirl.define do
  factory :spree_paypal_rest_checkout, class: 'Spree::PaypalRestCheckout' do
    token ''
    payer_id ''
    transaction_id nil
    refund_id nil
    web_profile_id ''
    refund_type ''
    state ''
    refunded_at nil
  end
end
