require "lpt_client"

class ConsoleController < ActionController::Base
  attr_accessor :profile_ext_id, :profile
  attr_accessor :instrument_ext_id, :instrument
  attr_accessor :instrument_token_ext_id, :instrument
  attr_accessor :payment_ext_id, :payment
  attr_accessor :merchant_ext_id

  def initialize(...)
    super

    configure
    reinit
  end

  def reinit
    @merchant_ext_id = LPT.merchant

    @profile_base = {
      name: "Testy Tester",
      contact: {
        phone: "2148831234",
        email: "testy@tester.com",
      }
    }

    @instrument_base = {
      name: "Testy Tester",
      contact: {
        phone: "2148831234",
        email: "testy@tester.com",
      },
      category: "CARD",
      account: "4242424242424242",
      expiration: {
        month: 10,
        year: 30
      },
      security_code: "999"
    }

    @register_instrument_base = {
      # entity: ::LPT.entity,
      # token: @instrument_token_ext_id,
      # profile: @profile_ext_id
    }

    @payment_base = {
      amount: 1337,
      currency: "USD",
      merchant: @merchant_ext_id,
      url: {
        success: "https://site.com/success",
        failure: "https://site.com/fail",
      }
    }

    @verification_base = {
      category: 'instrument',
      type: 'card',
      subject: '',
      merchant: @merchant_ext_id,
      url: {
        success: "https://site.com/success",
        failure: "https://site.com/fail",
      }
    }
  end

  def configure
    conf = ActiveSupport::OrderedOptions.new
    conf.environment = 'ivv'
    conf.api_username = 'LUS9e8edc646b3543c294abec60a19687bf'
    conf.api_password = 'qm4U3zJKXaTk7R8TZF5h6dHDmTDXKd3Y'
    conf.merchant = 'LMR91293daf8e534132885fd90bab293c5f'
    conf.entity = 'LEN29efb23b493640429ea2af5a31b96ef8'

    LPTClient.configure(conf)
  end


  def lpt_index
    ctrl = ::LPT::LPTController
    response = ctrl.check_access

    puts response
  end

  def get_profile
    profile = LPT::Resource::Profile.retrieve("LIDdb0834d5e5e94fd597d186b0bf7ae213")

    unless profile
      puts "Empty profile return!"
      return
    end

    profile.attributes
  end

  def test_profile
    # profileHash = {
    #   :name => "Testy Tester",
    #   :contact => {
    #     :phone => "2148831234",
    #     :email => "testy@tester.com",
    #   }
    # }


    @profile_request = ::LPT::Resource::ProfileRequest.new @profile_base

    profile = ::LPT::Resource::Profile.create(req)

    unless profile
      puts "Empty profile return!"
      return
    end

    return {
      :profileReqHash => profileHash,
      :req => req,
      :reqHash => req.serializable_hash,
      :profile => profile,
      :profileAttrs => profile.attributes,
      :profileHash => profile.as_compact_json,
    }
    # profile.attributes
  end

  def post_profile
    puts "Profile base: #{@profile_base}"

    @profile_request = ::LPT::Resource::ProfileRequest.new @profile_base

    puts @profile_request.as_compact_json

    @profile = ::LPT::Resource::Profile.create @profile_request
    unless @profile
      puts "POST Profile: Empty profile return!"
      return false
    end

    @profile_ext_id = @profile.id

    return true
  end

  def post_instrument_token
    @instrument_base[:profile] = nil
    @instrument_request = ::LPT::Resource::InstrumentRequest.new @instrument_base
    @instrument_request.entity = ::LPT.entity
    # @instrument_request.category = "TOKEN"
    @instrument_request.type = "TOKEN"

    @instrument = LPT::Resource::Instrument.create_token(@instrument_request)
    unless @instrument
      puts "POST Instrument: Empty instrument token return!"
      return false
    end

    @instrument_token_ext_id = @instrument.id

    return true
  end

  def post_instrument_register_token
    unless @profile_ext_id
      puts "Profile ID required to create instrument token!"
      return false
    end

    unless @instrument_token_ext_id
      puts "Token ID required to register instrument token!"
      return false
    end

    @register_instrument_base[:entity] = ::LPT.entity
    @register_instrument_base[:profile] = @profile_ext_id
    @register_instrument_base[:token] = @instrument_token_ext_id

    @register_token_request = ::LPT::Resource::InstrumentRequest.new @register_instrument_base

    @instrument = LPT::Resource::Instrument.create(@register_token_request)
    unless @instrument
      puts "POST Instrument: Empty token registration return!"
      return false
    end

    @instrument_ext_id = @instrument.id
  end

  def post_verify_instrument
    unless @instrument_ext_id
      puts "Instrument ID required to verify!"
      return false
    end

    @verification_base[:subject] = @instrument_ext_id
    @verification_base[:merchant] = @merchant_ext_id

    @verify_instrument_request = ::LPT::Resource::VerificationRequest.new @verification_base

    @verification = LPT::Resource::Verification.create(@verify_instrument_request)
    unless @verification
      puts "POST Verify: Empty verificatoin return!"
      return false
    end

    @verification_ext_id = @verification.id
  end

  def post_instrument
    unless @profile_ext_id
      puts "Profile ID required to create instrument!"
      return false
    end

    @instrument_base[:profile] = @profile_ext_id

    @instrument_request = ::LPT::Resource::InstrumentRequest.new @instrument_base

    @instrument = LPT::Resource::Instrument.create(@instrument_request)
    unless @instrument
      puts "POST Instrument: Empty instrument return!"
      return false
    end

    @instrument_ext_id = @instrument.id

    return true
  end

  def post_payment
    unless @profile_ext_id
      puts "Profile ID required to create payment!"
      return false
    end

    unless @instrument_ext_id
      puts "Instrument ID required to create payment!"
      return false
    end

    @payment_request = LPT::Resource::PaymentRequest.new @payment_base
    @payment_request.instrument = @instrument_ext_id

    @payment_request.validate

    @payment = LPT::Resource::Payment.create(@payment_request)
    unless @payment
      puts "POST Payment: Empty payment return!"
      return false
    end

    @payment_ext_id = @payment.id

    return true
  end

  def post_payment_capture
    unless @payment_ext_id
      puts "Payment ID required to capture payment!"
      return false
    end


    @payment.capture # = LPT::Resource::Payment.create(@payment_request)
    unless @payment
      puts "POST Payment: Empty payment capture return!"
      return false
    end

    puts "Payment Status: #{@payment.status}"
    @payment_ext_id = @payment.id

    return true
  end

  def post_payment_refund
    unless @payment_ext_id
      puts "Payment ID required to refund payment!"
      return false
    end


    @payment.refund # = LPT::Resource::Payment.create(@payment_request)
    unless @payment
      puts "POST Payment: Empty payment refund return!"
      return false
    end

    puts "Payment Status: #{@payment.status}"
    @payment_ext_id = @payment.id

    return true
  end

  def post_payment_reversal
    unless @payment_ext_id
      puts "Payment ID required to refund payment!"
      return false
    end

    @payment.reverse # = LPT::Resource::Payment.create(@payment_request)
    unless @payment
      puts "POST Payment: Empty payment reversal return!"
      return false
    end

    puts "Payment Status: #{@payment.status}"
    @payment_ext_id = @payment.id

    return true
  end

  def run_payment
    unless post_profile
      puts "run_payment: Profile failed!"
    end

    unless post_instrument_token
      puts "run_payment: Instrument Token failed!"
    end

    unless post_instrument_register_token
      puts "run_payment: Instrument Register Token failed!"
    end

    unless post_verify_instrument
      puts "run_payment: Instrument Verification failed!"
    end

    if post_payment
      puts "run_payment: Payment successful!"
    else
      puts "run_payment: Payment failed!"
    end

    if post_payment_reversal
      puts "run_payment: Payment reversal successful!"
    else
      puts "run_payment: Payment reversal failed!"
    end

    unless post_instrument
      puts "run_payment: Instrument failed!"
    end

    if post_payment
      puts "run_payment: 2nd Payment successful!"
    else
      puts "run_payment: 2nd Payment failed!"
    end

    if post_payment_capture
      puts "run_payment: 2nd Payment capture successful!"
    else
      puts "run_payment: 2nd Payment capture failed!"
    end

    if post_payment_refund
      puts "run_payment: 2nd Payment refund successful!"
    else
      puts "run_payment: 2nd Payment refund failed!"
    end

  end
end
