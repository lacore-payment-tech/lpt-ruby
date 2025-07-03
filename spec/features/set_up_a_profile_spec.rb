# frozen_string_literal: true

require "spec_helper"

RSpec.describe "set up a profile" do
  before { configure_client }

  it "can assign an instrument" do
    stub_profile_create
    stub_instrument_tokenize
    stub_instrument_create

    profile = create_profile(name: "Test Profile", email: "test@example.com",
                             phone: "+14155555555")
    token = create_token(card_number: "4242424242424242", security_code: "444",
                         expiration: "04/20444")
    instrument_token_request = Lpt::Requests::InstrumentTokenRequest.new
    instrument_token_request.token = token.id
    instrument = profile.associate_instrument(instrument_token_request)

    expect(instrument.id).to start_with(Lpt::PREFIX_INSTRUMENT)
  end

  def create_profile(name:, email:, phone:)
    profile_request = Lpt::Requests::ProfileRequest.new(
      name: name, contact: { phone: phone, email: email }
    )
    Lpt::Resources::Profile.create(profile_request)
  end

  def create_token(card_number:, security_code:, expiration:)
    instrument_token_request = Lpt::Requests::InstrumentTokenRequest.new(
      account: card_number, security_code: security_code, expiration: expiration
    )
    Lpt::Resources::Instrument.tokenize(instrument_token_request)
  end
end
