module Spree
  module Gateway::PaypalWebProfile
    
    def web_profile_class
      PayPal::SDK::REST::DataTypes::WebProfile
    end

    def create_profile(options)
      web_profile_class.new(request_hash(options)).create
    end

    def update_profile(id, options)
      find_profile(id).partial_update(options)
    end

    def delete_profile(id)
      find_profile(id).delete
    end

    def find_profile(id)
      web_profile_class.find(id)
    end

    def get_list
      # The API is inconsistent in that it returns an array of WebProfiles
      # instead of a JSON object with a property which should be a list
      # of WebProfiles.
      web_profile_class.get_list
    end

    def first_or_new(options)
      list = get_list
      if list.empty?
        web_profile_class.new(request_hash(options))
      else
        list.first
      end
    end

    def request_hash(options)
      {
        name: options[:profile_name],
        presentation:{
          brand_name: options[:brand_name],
          locale_code: options[:locale_code],
        },
        input_fields:{
          allow_note: options[:allow_note],
          no_shipping: options[:no_shipping],
          address_override: options[:address_override],
        },
        flow_config:{
          landing_page_type: options[:landing_page_type],
          return_uri_http_method: 'get'
        }
      }
    end

  end
end