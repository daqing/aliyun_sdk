# AliyunSDK (基础通用 Ruby SDK)

## 安装

添加到 Gemfile：

```ruby
gem 'aliyun_sdk'
```

## 使用方法

```ruby
require 'aliyun_sdk'

config = AliyunSDK::Config.new(
  access_key_id: 'YourAccessKeyId',
  access_key_secret: 'YourAccessKeySecret'
)

client = AliyunSDK::Client.new(config)

# 以 CloudAuth DescribeVerifyToken 为例
result = client.cloud_auth_request('DescribeVerifyToken', { 'BizId' => 'xxx' })
puts result
```

## 扩展

你可以通过传递不同的 Action 和参数，访问任意阿里云 OpenAPI。

---

本 SDK 仅实现基础签名和请求封装，适合自定义扩展。
