$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'sinatra'
require 'rack/test'
require 'spec'
require 'spec/autorun'

set :environment, :test
require 'sinatra/flash'
require 'sinatra/sessionography'

get '/dummy' do
  "This page does not invoke the flash at all."
end

get '/flash' do
  if params[:key]
    flash(params[:key]).inspect
  else
    flash.inspect
  end
end

post '/flash' do
  if (key = params.delete('key'))
    params.each{|k,v| flash(key)[k.to_sym] = v.to_sym}
    flash(key).inspect
  else
    params.each{|k,v| flash[k.to_sym] = v.to_sym}
    flash.inspect
  end
end
    

# Stub out our application; it's silly, but we have to do it. (http://www.sinatrarb.com/testing.html)
module SinatraApp
  def app
    Sinatra::Application
  end
end

Spec::Runner.configure do |config|
  include SinatraApp
  include Rack::Test::Methods
  
end
