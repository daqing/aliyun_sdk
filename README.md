# AliyunSDK (基础通用 Ruby SDK)

## 安装

添加到 Gemfile：

```ruby
gem 'aliyun_sdk_ruby', '~> 0.3', require: 'aliyun_sdk'
```

## 注意

虽然 Gem 的名称是 `aliyun_sdk_ruby`, 但是
引入的代码是: `require 'aliyun_sdk'`

为什么这样？因为 `aliyun_sdk` 这个名字，和现有的
`aliyun-sdk` 名称非常相似，在执行 `gem push` 时
RubyGems.org 拒绝让我发布，于是我把 gem 名称修改
为 `aliyun_sdk_ruby`。


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
