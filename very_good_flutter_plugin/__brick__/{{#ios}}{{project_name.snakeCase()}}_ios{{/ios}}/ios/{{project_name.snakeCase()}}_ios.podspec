#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = '{{project_name.snakeCase()}}_ios'
  s.version          = '0.0.1'
  s.summary          = 'An iOS implementation of the {{project_name.snakeCase()}} plugin.'
  s.description      = <<-DESC
  An iOS implementation of the {{project_name.snakeCase()}} plugin.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :type => 'BSD', :file => '../LICENSE' }
  s.author           = { '{{org_name.titleCase()}}' => 'email@example.com' }
  s.source           = { :path => '.' }  
  s.source_files = '{{project_name.snakeCase()}}_ios/Sources/**/*.swift'
  s.dependency 'Flutter'
  s.platform = :ios, '13.0'
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
  s.swift_version = '6.1'
end
