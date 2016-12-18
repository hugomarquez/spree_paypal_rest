module SpreePaypalRest
  class Engine < ::Rails::Engine
    config.generators do |g|
      g.test_framework  :rspec, fixture: false
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
      g.assets false
      g.helper false
    end

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), '../../app/**/*_decorator*.rb')) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
    end

    config.to_prepare &method(:activate).to_proc

    initializer 'spree.paypal_rest.payment_methods', after: 'spree.register.payment_methods' do |app|
      app.config.spree.payment_methods += [
        Spree::Gateway::PaypalExpress
      ]
    end

  end
end
