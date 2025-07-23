require "openssl"
require "base64"
require "cgi"

module AliyunSDK
  class Signer
    def self.sign(params, access_key_secret, http_method = "GET")
      sorted = params.sort.to_h
      canonicalized = sorted.map { |k, v| "#{percent_encode(k)}=#{percent_encode(v)}" }.join("&")
      string_to_sign = "#{http_method.upcase}&%2F&" + percent_encode(canonicalized)
      key = "#{access_key_secret}&"
      digest = OpenSSL::HMAC.digest("sha1", key, string_to_sign)
      Base64.strict_encode64(digest)
    end

    def self.percent_encode(str)
      CGI.escape(str.to_s).gsub("+", "%20").gsub("*", "%2A").gsub("%7E", "~")
    end
  end
end
