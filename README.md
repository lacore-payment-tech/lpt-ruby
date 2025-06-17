# LPT
Ruby API Client

## Installation
Add this line to your application's Gemfile:

```ruby
gem "lpt"
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install lpt
```

## Testing & Examples
See: `/test/dummy/app/controllers/console_controller.rb`

Configuration file: `/test/dummy/app/config/lpt.yml`

Make sure to adjust environment parameter and set:
* username
* password
* merchant ID 
* merchant account ID (optional)
* entity ID


Once complete, run:
```shell
bash -c "test/dummy/bin/rails console"
```

Run payment actions:
```ruby
ctrl = ConsoleController.new

ctrl.post_profile ## create profile
ctrl.post_instrument_token ## create token (simulates hosted fields)
ctrl.post_instrument_register_token ## associate token & profile, get LPI ID
ctrl.post_verify_instrument ## run verification on token
ctrl.post_payment ## authorize payment
ctrl.post_payment_reversal ## reverse authorization

ctrl.post_instrument ## create instrument directly
ctrl.post_payment ## authorize a new payment with the new instrument
ctrl.post_payment_capture ## capture this payment
ctrl.post_payment_refund ## now refund the payment

## run all the steps above in one shot
ctrl.run_payments
```