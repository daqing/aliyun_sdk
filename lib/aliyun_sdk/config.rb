module AliyunSDK
  class Config
    DEFAULT_REGION = "cn-hangzhou"
    DEFAULT_ENDPOINT = "https://ecs.aliyuncs.com"

    attr_accessor :access_key_id, :access_key_secret
    attr_reader :region_id, :endpoint

    # @param access_key_id [String]
    # @param access_key_secret [String]
    def initialize(access_key_id:, access_key_secret:)
      @access_key_id = access_key_id
      @access_key_secret = access_key_secret
      @region_id = DEFAULT_REGION
      @endpoint = DEFAULT_ENDPOINT
    end
  end
end
