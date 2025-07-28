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

    # 返回统一的格式：
    #
    # 正常返回:
    # { code: 0, data: {hello: "world"}, message: ""}
    #
    # 异常返回:
    # { code: 500, data: nil, message: "internal error" }
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
      api.handle_response(JSON.parse(response.body))
    rescue RestClient::ExceptionWithResponse => e
      { code: 500, data: nil, message: e.response }
    end
  end
end
