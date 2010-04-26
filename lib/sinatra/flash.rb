require 'sinatra/base'
require 'sinatra/flash/hash'


module Sinatra
  module Flash
    module Helpers
      
      # The main Sinatra helper for accessing the flash. You can have multiple flash collections (e.g.,
      # for different apps in your Rack stack) by passing a symbol to it.
      # 
      # @param [optional, String, Symbol] key Specifies which key in the session contains the hash
      # you want to reference. Defaults to ':flash'. If there is no session or the key is not found, 
      # an empty hash is used.
      #
      # @return [FlashHash]
      def flash(key=:flash)
        @flash ||= {}
        @flash[key.to_sym] ||= FlashHash.new((session ? session[key.to_sym] : {}))
      end
    end
    
    after do
      set :sessions, true  # If you do not have a session, one will be appointed for you by the court.
      @flash.each{|key, flash| session[key] = @flash[key].next}
    end
    
    # # If you do not have a session, one will be appointed for you by the court.
    # after do
    #   set :sessions, true
    #   session[:flash] = flash.next
    # end
      
    helpers Helpers
  end
  register Flash
  puts self.included_modules
end