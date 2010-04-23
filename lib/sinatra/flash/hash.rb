require 'delegate'

module Sinatra
  module Flash
    
    # A subclass of Hash that "remembers forward" by exactly one action. 
    # Tastes just like the API of Rails's ActionController::Flash::FlashHash, but with fewer calories.
    class FlashHash < DelegateClass(Hash)
      attr_reader :now, :next
      
      # Builds a new FlashHash. It takes the hash for this action's values as an initialization variable.
      def initialize(session)
        @now = session || Hash.new
        @next = Hash.new
        super(@now)
      end
      
      # We assign to the _next_ hash, but retrieve values from the _now_ hash.  Freaky, huh?  
      def []=(key, value)
        self.next[key] = value
      end
      
      # Swaps out the current flash for the future flash, then returns it.
      def sweep
        @now.replace(@next)
        @next = Hash.new
        @now
      end
      
      # Keep all or one of the current values for next time.
      def keep(key=nil)
        if key
          @next[key] = @now[key]
        else
          @next.merge!(@now)
        end
      end
      
      # Tosses any values or one value before next time.
      def discard(key=nil)
        if key
          @next.delete(key)
        else
          @next = Hash.new
        end
      end
    end
  end
end