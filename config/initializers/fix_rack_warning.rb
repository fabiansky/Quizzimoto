# Fix warnings such as:
#
#   warning: regexp match /.../n against to UTF-8 string
#
# See: http://stackoverflow.com/questions/3622394/ruby-1-9-2-strange-warning-when-running-cucumber-specs

if Rack.release.to_f <= 1.2
  module Rack
    module Utils
      def escape(s)
        CGI.escape(s.to_s)
      end
      
      def unescape(s)
        CGI.unescape(s)
      end
    end
  end
end