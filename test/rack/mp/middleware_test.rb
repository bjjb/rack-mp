require 'test_helper'
require 'json'
require 'rack/mp/middleware'

describe Rack::MP::Middleware do
  include Rack::Test::Methods

  let(:middleware) do
    Rack::MP::Middleware
  end

  let(:app) do
    Rack::Builder.new do
      use Rack::MP::Middleware
      run lambda { |env| [200, {}, ["OK"]] }
    end
  end

  let(:data) do
    JSON.parse(last_response.body)
  end

  let(:header) do
    JSON.parse(last_response.header['X-MP-ObjectCounts'])
  end

  it "can be used to see object counts" do
    get "/"
    last_response.must_be :ok?
    last_response.header.keys.wont_include 'X-MP-ObjectCounts'
    get "/?__mp__=counts"
    last_response.must_be :ok?
    last_response.header.keys.must_include 'X-MP-ObjectCounts'
    header.keys.must_include("before")
    header.keys.must_include("after")
    header.keys.must_include("timings")
  end
end
