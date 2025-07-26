require_relative "lib/aliyun_sdk/version"

Gem::Specification.new do |spec|
  spec.name          = "aliyun_sdk"
  spec.version       = AliyunSDK::VERSION
  spec.authors       = ["David Zhang"]
  spec.email         = ["daqing@mzevo.com"]
  spec.summary       = "Aliyun Ruby SDK"
  spec.description   = "Aliyun SDK for Ruby"
  spec.homepage      = "https://github.com/daqing/aliyun_sdk"
  spec.license       = "MIT"

  spec.files         = Dir["lib/**/*.rb", "README.md"]
  spec.require_paths = ["lib"]
  spec.required_ruby_version = ">= 3.3"

  spec.add_dependency "rest-client"
end
