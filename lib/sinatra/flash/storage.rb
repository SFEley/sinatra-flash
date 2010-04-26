require 'sinatra/flash/hash'

module Sinatra
  module Flash
    module Storage
  
      # The main Sinatra helper for accessing the flash. You can have multiple flash collections (e.g.,
      # for different apps in your Rack stack) by passing a symbol to it.
      # 
      # @param [optional, String, Symbol] key Specifies which key in the session contains the hash
      # you want to reference. Defaults to ':flash'. If there is no session or the key is not found, 
      # an empty hash is used.  Note that this is only used in the case of multiple flash _collections_,
      # which is rarer than multiple flash messages.
      #
      # @return [FlashHash] Assign to this like any other hash.
      def flash(key=:flash)
        @flash ||= {}
        @flash[key.to_sym] ||= FlashHash.new((session ? session[key.to_sym] : {}))
      end
      
    end
  end
end
