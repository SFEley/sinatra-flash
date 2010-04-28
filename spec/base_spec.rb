require File.dirname(__FILE__) + '/spec_helper'
require 'sinatra/base'

class BaseApp < Sinatra::Base
  helpers Sinatra::Sessionography
  register Sinatra::Flash
  
  
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

end

describe "Sinatra::Flash in a Sinatra::Base application" do
  
  def app
    BaseApp
  end
  
  before(:each) do
    Sinatra::Sessionography.session = nil
  end
  
  it "shows nothing when no flash has been set" do
    get '/flash'
    last_response.body.should == "{}"
  end
  
  it "can set and retrieve the flash" do
    post '/flash', {:foo => :bar}
    get '/flash'
    last_response.body.should == "{:foo=>:bar}"
  end
  
end