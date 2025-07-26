module AliyunSDK
  class Config
    DEFAULT_REGION = "cn-hangzhou".freeze

    attr_reader :access_key_id, :access_key_secret, :region_id

    # @param access_key_id [String]
    # @param access_key_secret [String]
    def initialize(access_key_id:, access_key_secret:)
      @access_key_id = access_key_id
      @access_key_secret = access_key_secret
      @region_id = DEFAULT_REGION
    end
  end
end
