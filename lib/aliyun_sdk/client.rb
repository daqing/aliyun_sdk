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

    def request(action, params = {}, method: "GET")
      public_params = {
        "Format" => "JSON",
        "Version" => params.delete("Version") || "2014-05-26",
        "AccessKeyId" => @config.access_key_id,
        "SignatureMethod" => "HMAC-SHA1",
        "Timestamp" => Time.now.utc.strftime("%Y-%m-%dT%H:%M:%SZ"),
        "SignatureVersion" => "1.0",
        "SignatureNonce" => SecureRandom.uuid,
        "Action" => action,
        "RegionId" => @config.region_id
      }
      all_params = public_params.merge(params)
      signature = Signer.sign(all_params, @config.access_key_secret, method)
      all_params["Signature"] = signature

      response = if method == "GET"
                   RestClient.get(@config.endpoint, { params: all_params })
                 else
                   RestClient.post(@config.endpoint, all_params)
                 end
      JSON.parse(response.body)
    rescue RestClient::ExceptionWithResponse => e
      { "error" => e.response }
    end

    CLOUDAUTH_ENDPOINT = "cloudauth.cn-hangzhou.aliyuncs.com"
    CLOUDAUTH_VERSION = "2019-03-07"

    # CloudAuth 通用请求
    # @param action [String] CloudAuth API 名称
    # @param params [Hash] 业务参数
    # @param method [String] HTTP 方法，默认 POST
    # @return [Hash] API 响应
    def cloud_auth_request(action, params = {}, method: "POST")
      public_params = {
        "Format" => "JSON",
        "Version" => CLOUDAUTH_VERSION,
        "AccessKeyId" => @config.access_key_id,
        "SignatureMethod" => "HMAC-SHA1",
        "Timestamp" => Time.now.utc.strftime("%Y-%m-%dT%H:%M:%SZ"),
        "SignatureVersion" => "1.0",
        "SignatureNonce" => SecureRandom.uuid,
        "Action" => action,
        "RegionId" => @config.region_id
      }
      all_params = public_params.merge(params)
      signature = Signer.sign(all_params, @config.access_key_secret, method)
      all_params["Signature"] = signature

      response = if method == "GET"
                   RestClient.get("https://#{CLOUDAUTH_ENDPOINT}", { params: all_params })
                 else
                   RestClient.post("https://#{CLOUDAUTH_ENDPOINT}", all_params)
                 end
      JSON.parse(response.body)
    rescue RestClient::ExceptionWithResponse => e
      { "error" => e.response }
    end
  end
end
