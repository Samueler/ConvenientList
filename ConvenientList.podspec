Pod::Spec.new do |s|
  s.name             = 'ConvenientList'
  s.version          = '1.0.0'
  s.summary          = 'ConvenientList by Swift'
  s.homepage         = 'https://github.com/Samueler/ConvenientList'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Samueler' => 'samueler.chen@gmail.com' }
  s.source           = { :git => 'https://github.com/Samueler/ConvenientList.git', :tag => s.version.to_s }
  s.ios.deployment_target = '10.0'
  s.source_files = 'ConvenientList/Classes/**/*'
  
  
end
