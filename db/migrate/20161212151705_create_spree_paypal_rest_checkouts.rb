class CreateSpreePaypalRestCheckouts < ActiveRecord::Migration
  def change
    create_table :spree_paypal_rest_checkouts do |t|
      t.string    :token
      t.string    :payer_id 
      t.string    :transaction_id,  index: true
      t.string    :refund_id,       index: true
      t.string    :web_profile_id
      t.string    :refund_type
      t.string    :state
      t.datetime  :refunded_at
      t.timestamps null: false
    end
  end
end
