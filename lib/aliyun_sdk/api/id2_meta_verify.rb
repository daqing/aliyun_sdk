module AliyunSDK
  module API
    # 实人认证 - 身份二要素核验
    #
    # API 返回结果:
    #
    # 姓名和身份证匹配:
    # {
    #   "ResultObject" => {"BizCode" => "1"},
    #   "RequestId" => "4924E5D4-874C-5062-9E37-992D85EDDFAE",
    #   "Message" => "success",
    #   "Code" => "200"
    # }
    #
    # 姓名和身份证不匹配:
    # {
    #   "ResultObject" => {"BizCode" => "2"},
    #   "RequestId" => "7CB9FE8B-8A9F-5E49-8C17-4DD4B1C724A2",
    #   "Message" => "success",
    #   "Code" => "200"
    # }
    #
    # 身份证非法:
    # {
    #   "RequestId" => "24394B83-EE10-5C5F-A0BC-FBC680A694A4",
    #   "HostId" => "cloudauth.cn-hangzhou.aliyuncs.com",
    #   "Code" => "401",
    #   "Message" => "参数非法(identifyNum)",
    #   "Recommend" => "https://api.aliyun.com/troubleshoot?q=401&product=Cloudauth&requestId=24394B83-EE10-5C5F-A0BC-FBC680A694A4"
    # }
    class Id2MetaVerify
      # @param username [String] 姓名
      # @param id_number [String] 身份证号
      def initialize(username, id_number)
        @username = username
        @id_number = id_number
      end

      def request_action
        "Id2MetaVerify"
      end

      def request_method
        "POST"
      end

      def request_params
        {
          "ParamType" => "normal",
          "IdentifyNum" => @id_number,
          "UserName" => @username
        }
      end

      def request_endpoint
        "cloudauth.cn-hangzhou.aliyuncs.com"
      end

      def request_version
        "2019-03-07"
      end
    end
  end
end
