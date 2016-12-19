module Spree
  CheckoutController.class_eval do
    before_filter :paypal_rest_hook, only: :update, if: proc { params[:state].eql?('payment') }
    
    def paypal_express
      if @order.update_from_params(params, permitted_checkout_attributes, request.headers.env)
        @payment_method = PaymentMethod.find(params[:order][:payments_attributes].first[:payment_method_id])
        @payment = @payment_method.request_payment(@order)
        if @payment.create
          @redirect_url = @payment.links.find{|v| v.method == "REDIRECT" }.href
          redirect_to @redirect_url
        else
          flash[:error] = @payment.error.inspect
          render :edit
        end
      end
    end

    def paypal_express_return
      paypal_checkout = Spree::PaypalRestCheckout.new(
        token: params[:token],
        payer_id: params[:PayerID],
        transaction_id: params[:paymentId],
        state: params[:state]
      )

      payment = @order.payments.last
      
      if payment.present?
        if payment.payment_method.kind_of?(Spree::Gateway::PaypalExpress)
          payment.update!({source: paypal_checkout})
        end
      else
        @order.payments.create!({
          source: paypal_checkout,
          amount: @order.total,
          payment_method: @order.payments.last.payment_method
        })
      end

      until @order.state == "complete"
        if @order.next!
          @order.update_with_updater!
        end
      end
      
      flash.notice = Spree.t(:order_processed_successfully)
      redirect_to completion_route
    end

    def paypal_express_cancel
      flash[:error] = Spree.t(:payment_has_been_cancelled)
      redirect_to edit_order_path(@order)
    end

    private

    def paypal_rest_hook
      return unless params[:order] && params[:order][:payments_attributes]
      payment_method = PaymentMethod.find(params[:order][:payments_attributes].first[:payment_method_id])
      if payment_method.kind_of?(Spree::Gateway::PaypalExpress)
        paypal_express
      end
    end


  end
end