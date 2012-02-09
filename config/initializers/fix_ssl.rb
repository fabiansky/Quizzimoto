# Work around errors that look like:
#
#   SSL_connect returned=1 errno=0 state=SSLv3 read server certificate B: certificate verify failed (OpenSSL::SSL::SSLError)
#
# See:
# 
#   * http://martinottenwaelter.fr/2010/12/ruby19-and-the-ssl-error/
#   * http://jimneath.org/2011/10/19/ruby-ssl-certificate-verify-failed.html
#   * http://code.google.com/p/google-plus-ruby-starter/issues/detail?id=3#c6
#   * http://www.rubyinside.com/how-to-cure-nethttps-risky-default-https-behavior-4010.html
#   * http://stackoverflow.com/questions/5074164/google-api-ruby-client-translate-api-examples

require 'open-uri'
require 'net/https'

module Net
  class HTTP
    alias_method :original_use_ssl=, :use_ssl=
    
    def use_ssl=(flag)
      # Ubuntu
      if File.exists?('/etc/ssl/certs')
        self.ca_path = '/etc/ssl/certs'
      
      # MacPorts on OS X
      # You'll need to run: sudo port install curl-ca-bundle
      elsif File.exists?('/opt/local/share/curl/curl-ca-bundle.crt')
        self.ca_file = '/opt/local/share/curl/curl-ca-bundle.crt'
      end

      self.verify_mode = OpenSSL::SSL::VERIFY_PEER
      self.original_use_ssl = flag
    end
  end
end