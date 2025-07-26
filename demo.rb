require_relative "lib/aliyun_sdk"

if ARGV.size < 2
  puts "main.rb [access_key_id] [access_key_secret]"
  exit(1)
end

config = AliyunSDK::Config.new(access_key_id: ARGV[0],
                               access_key_secret: ARGV[1])

client = AliyunSDK::Client.new(config)

api = AliyunSDK::API::Id2MetaVerify.new("张三", "370503199922113344")
response = client.request(api)

puts response
