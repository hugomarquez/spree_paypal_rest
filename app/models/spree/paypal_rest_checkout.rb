class Spree::PaypalRestCheckout < ActiveRecord::Base
  has_many :payments, as: :source
  
  scope :in_state, ->(state) { where(state: state) }
  scope :not_in_state, ->(state) { where.not(state: state) }
  
end
