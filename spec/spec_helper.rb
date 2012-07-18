require 'rspec'
require 'webmock/rspec'

require 'ratis'

RSpec.configure do |config|
  config.color_enabled = true
  config.formatter     = 'documentation'
end

def stub_atis_request
  stub_request(:post, 'soap.valleymetro.org/cgi-bin-soap-web-new/soap.cgi')
end

def an_atis_request
  a_request(:post, 'soap.valleymetro.org/cgi-bin-soap-web-new/soap.cgi')
end

def atis_response action, version, action_response_code, action_response_body
  { body: <<-BODY }
  <?xml version="1.0" encoding="UTF-8"?>
  <SOAP-ENV:Envelope xmlns:xsi="http://www.w3.org/1999/XMLSchema-instance" xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/" xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsd="http://www.w3.org/1999/XMLSchema" SOAP-ENV:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">
    <SOAP-ENV:Body>
      <namesp1:#{action}Response xmlns:namesp1="PX_WEB">
        <Responsecode>#{action_response_code}</Responsecode>
        <Version>#{version}</Version>
        #{action_response_body}
        <Copyright>XML schema Copyright (c) 2011 Trapeze Software, Inc., all rights reserved.</Copyright>
        <Soapversion>2.4.4 - 08/31/11</Soapversion>
      </namesp1:#{action}Response>
    </SOAP-ENV:Body>
  </SOAP-ENV:Envelope>
  BODY
end

