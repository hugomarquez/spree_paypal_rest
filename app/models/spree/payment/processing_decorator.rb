module Spree
  Payment::Processing.module_eval do 
    
    def cancel!
      byebug
      if payment_method.kind_of?(Spree::Gateway::PaypalExpress)
        response = payment_method.cancel(id)
        handle_response(response, :void, :failure)
      else
        response = payment_method.cancel(response_code)
        handle_response(response, :void, :failure)
      end
    end

  end
end