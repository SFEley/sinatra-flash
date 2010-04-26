module Sinatra
  module Flash
    module Style

      # A view helper for rendering flash messages to HTML with reasonable CSS structure. Handles 
      # multiple flash messages in one request. Wraps them in a <div> tag with id #flash containing
      # a <div> for each message with classes of .flash and the message type.  E.g.:
      #
      # @example
      #   <div id='flash'>
      #     <div class='flash info'>Today is Tuesday, April 27th.</div>
      #     <div class='flash warning'>Missiles are headed to destroy the Earth!</div>
      #   </div>
      #
      # It is your responsibility to style these classes the way you want in your stylesheets.
      #
      # @param[optional, String, Symbol] key Specifies which flash collection you want to display. 
      #   If you use this, the collection key will be appended to the top-level div id (e.g.,
      #   'flash_login' if you pass a key of  :login).  
      #
      # @return [String] Styled HTML if the flash contains messages, or an empty string if it's empty.
      def styled_flash(key=:flash)
        return "" if flash(key).empty?
        id = (key == :flash ? "flash" : "flash_#{key}")
        messages = flash(key).collect {|message| "  <div class='flash #{message[0]}'>#{message[1]}</div>\n"}
        "<div id='#{id}'>\n" + messages.join + "</div>"
      end
      
    end
  end
end


