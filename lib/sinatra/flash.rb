require 'sinatra/base'
require 'sinatra/flash/storage'
require 'sinatra/flash/style'


module Sinatra
  module Flash
    
    # This callback rotates any flash structure we referenced, placing the 'next' hash into the session
    # for the next request.
    after do
      set :sessions, true unless session # If you do not have a session, one will be appointed for you by the court.
      @flash.each{|key, flash| session[key] = @flash[key].next}
    end
    
    helpers Storage
    helpers Style
  end
  register Flash
end