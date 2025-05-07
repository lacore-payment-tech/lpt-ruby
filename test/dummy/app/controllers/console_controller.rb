class ConsoleController < ActionController::Base
  attr_accessor :profile_ext_id, :profile
  attr_accessor :instrument_ext_id, :instrument
  attr_accessor :payment_ext_id, :payment
  attr_accessor :merchant_ext_id

  def initialize(...)
    super

    @merchant_ext_id = ::LPT.merchant

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

    @payment_base = {
      amount: 1337,
      currency: "USD",
      merchant: @merchant_ext_id,
    }
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

    profile = LPT::Resource::Profile.create(req)

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

    @profile = LPT::Resource::Profile.create @profile_request
    unless @profile
      puts "POST Profile: Empty profile return!"
      return false
    end

    @profile_ext_id = @profile.id

    return true
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

  def run_payment
    unless post_profile
      puts "run_payment: Profile failed!"
    end

    unless post_instrument
      puts "run_payment: Instrument failed!"
    end

    if post_payment
      puts "run_payment: Payment successful!"
    else
      puts "run_payment: Payment failed!"
    end

  end
end
