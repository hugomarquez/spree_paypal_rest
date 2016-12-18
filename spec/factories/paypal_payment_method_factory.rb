FactoryGirl.define do
  factory :paypal_express_payment_method, class: Spree::Gateway::BogusSimple do
    type          "Spree::Gateway::PaypalExpress"
    name          "Paypal Express"
    description   "Paypal Express"
    display_on    "both"
    active        true
    auto_capture  true
    test_mode     true
  end
end