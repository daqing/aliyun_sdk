# AliyunSDK (基础通用 Ruby SDK)

## 安装

添加到 Gemfile：

```ruby
gem 'aliyun_sdk', github: "daqing/aliyun_sdk"
```

## 使用方法

```ruby
require 'aliyun_sdk'

config = AliyunSDK::Config.new(
  access_key_id: "YourAccessKeyID",
  access_key_secret: "YourAccessKeySecret"
)

client = AliyunSDK::Client.new(config)

api = AliyunSDK::API::Id2MetaVerify.new("张三", "370503199922113344")
response = client.request(api)

puts response
```

---

本 SDK 仅实现基础签名和请求封装，适合自定义扩展。
