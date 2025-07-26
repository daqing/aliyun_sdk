require "rest-client"
require "json"
require "securerandom"
require_relative "config"
require_relative "signer"

module AliyunSDK
  class Client
    def initialize(config)
      @config = config
    end

    def request(api)
      public_params = {
        "Format" => "JSON",
        "Version" => api.request_version,
        "AccessKeyId" => @config.access_key_id,
        "SignatureMethod" => "HMAC-SHA1",
        "Timestamp" => Time.now.utc.strftime("%Y-%m-%dT%H:%M:%SZ"),
        "SignatureVersion" => "1.0",
        "SignatureNonce" => SecureRandom.uuid,
        "Action" => api.request_action,
        "RegionId" => @config.region_id
      }

      method = api.request_method
      all_params = public_params.merge(api.request_params)
      signature = Signer.sign(all_params, @config.access_key_secret, method)
      all_params["Signature"] = signature

      endpoint = api.request_endpoint
      response = if method == "GET"
                   RestClient.get("https://#{endpoint}", { params: all_params })
                 else
                   RestClient.post("https://#{endpoint}", all_params)
                 end
      JSON.parse(response.body)
    rescue RestClient::ExceptionWithResponse => e
      { "Code" => "500", "Message" => e.response }
    end
  end
end
