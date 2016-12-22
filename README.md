# Spree Paypal REST
[![Gem Version](https://badge.fury.io/rb/spree_paypal_rest.svg)](https://badge.fury.io/rb/spree_paypal_rest)
[![Build Status](https://travis-ci.org/hugomarquez/spree_paypal_rest.svg?branch=master)](https://travis-ci.org/hugomarquez/spree_paypal_rest)
[![Coverage Status](https://coveralls.io/repos/github/hugomarquez/spree_paypal_rest/badge.svg?branch=master)](https://coveralls.io/github/hugomarquez/spree_paypal_rest?branch=master)


This is a Paypal REST SDK extension for Spree.

Behind the scenes, this extension uses [Paypal Ruby SDK](https://github.com/paypal/PayPal-Ruby-SDK).

### Why?
* The Official [Spree Paypal Express](https://github.com/spree-contrib/better_spree_paypal_express) extension for Spree latest update was a year ago.
* Braintree is not available in some countries.
* Support for Spree latest stable release 3.1

## Features
* Paypal Express Checkout/Payment Experience API integration.
* Support for Promotions and Adjustments.
* Let Spree handle Orders and Payments flow.
* Fixes promotion code not detected when enter key is pressed in payment form. https://github.com/spree-contrib/better_spree_paypal_express/issues/119

## Installation
Before installing this extension please follow Spree installation Guide.
    
    cd my_project
    echo "gem 'spree_paypal_rest', '1.0.0'" >> Gemfile
    bundle
    rails g spree_paypal_rest:install
    rails server
        
## Sandbox Setup

### Paypal

Go to [PayPal's Developer Website](https://developer.paypal.com/), sign in with your PayPal account, click "Sandbox -> Accounts" and create a new "Business" account. Once the account is created, click on "My Apps & Credentials" scroll down to REST API apps and create a new app, select your app's name and sandbox business account.

Click on your app to access Sandbox API Credentials.

You will also need a "Personal" account to test the transactions on your site. Create this in the same way, finding the account information under "Profile" as well. You may need to set a password in order to be able to log in to PayPal's sandbox for this user. **(There is no need to create a REST API App for this account)**

### Spree Backend

In Spree, go to the admin backend, click "Configuration -> Payment Methods" and create a new payment method. Select "Spree::Gateway::PaypalExpress" as the provider, and click "Create".

Then enter the following information for your paypal **Business** Account:
* Brand Name
* Address Override
* Landing Page Type
* Temporary
* Locale Code
* Profile Name
* Logo URL
* Server
* Client ID
* Client Secret
* Test Mode
* Auto Capture

**For information on this fields and Paypal REST API in general, please take a look at the paypal REST API documentation**

* [REST API reference](https://developer.paypal.com/docs/api/)
* [Payment Experience API](https://developer.paypal.com/docs/api/payment-experience/)
* [Payments API](https://developer.paypal.com/docs/api/payments/)

## TO-DO
* Internationalization.
* More testing.
* Follow Spree versioning style.
* Add store return and cancel url paths for PaypalPayment#payment_payload


## Contributing

In the spirit of free software, **everyone** is encouraged to help improve this project.

Here are some ways *you* can contribute:

* by using prerelease versions
* by reporting [bugs][2]
* by suggesting new features
* by writing or editing documentation
* by writing specifications
* by writing code (*no patch is too small*: fix typos, add comments, clean up inconsistent whitespace)
* by refactoring code
* by resolving [issues][2]
* by reviewing patches

Starting point:

* Fork the repo
* Clone your repo
* Run `bundle install`
* Make your changes
* Ensure specs pass by running `bundle exec rspec spec`
* Submit your pull request

[2]: https://github.com/spree/better_spree_paypal_express/issues

## License
Licensed under the MIT license. Full details can be found in the MIT-LICENSE file in the root of the repository.