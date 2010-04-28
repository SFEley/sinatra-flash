require 'sinatra/base'
require 'sinatra/flash/storage'
require 'sinatra/flash/style'


module Sinatra
  module Flash
    
    def self.registered(app)
      app.helpers Flash::Storage
      app.helpers Flash::Style

      # This callback rotates any flash structure we referenced, placing the 'next' hash into the session
      # for the next request.
      app.after do
        set :sessions, true unless session # If you do not have a session, one will be appointed for you by the court.
        @flash.each{|key, flash| session[key] = @flash[key].next}
      end
    end

  end
  
  register Flash
end