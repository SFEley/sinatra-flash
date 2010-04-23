$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'sinatra'
require 'rack/test'
require 'sinatra/flash'
require 'spec'
require 'spec/autorun'

# Stub out our application; it's silly, but we have to do it. (http://www.sinatrarb.com/testing.html)
module SinatraApp
  def app
    @app ||= Sinatra::Application
  end
end

Spec::Runner.configure do |config|
  include Rack::Test::Methods
  include SinatraApp
  
end
