Pod::Spec.new do |s|
  s.name             = 'RedpacketLib'
  s.version          = '2.0.2'
  s.summary          = 'RedpacketUILib'
  s.description      = <<-DESC
                       * RedpacketUILib.
                       * Redpacket
                       * Alipay
                       * 支付宝支付
                       * 红包SDK
                       * 收红包直接到支付宝账户
                       DESC

  s.homepage         = 'http://yunzhanghu.com'
  #s.license          = { :type => 'MIT' }
  s.author           = { 'Mr.Yang' => 'tonggang.yang@yunzhanghu.com' }
  s.source           = { :git => 'https://github.com/YunzhanghuOpen/cocoapods-redpacket-api.git', :tag => "#{s.version}" }

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.xcconfig     = {'OTHER_LDFLAGS' => '-ObjC'}
  s.source_files = 'RedpacketLib/**/*.{h,m}'
  s.resources = ['resources/*.bundle']
  s.frameworks = 'AudioToolbox'
  s.documentation_url = 'https://docs.yunzhanghu.com/integration/ios.html'
  s.dependency 'RedpacketAliAuthAPILib'

end
