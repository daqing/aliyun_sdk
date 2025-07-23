# AliyunSDK (基础通用 Ruby SDK)

## 安装依赖

```sh
gem install rest-client
```

## 使用方法

```ruby
require_relative 'config'
require_relative 'client'

config = AliyunSDK::Config.new(
  access_key_id: '你的AccessKeyId',
  access_key_secret: '你的AccessKeySecret'
)

client = AliyunSDK::Client.new(config)

# 以 ECS DescribeInstances 为例
result = client.request('DescribeInstances', { 'Version' => '2014-05-26' })
puts result
```

## 扩展

你可以通过传递不同的 Action 和参数，访问任意阿里云 OpenAPI。

---

本 SDK 仅实现基础签名和请求封装，适合自定义扩展。
