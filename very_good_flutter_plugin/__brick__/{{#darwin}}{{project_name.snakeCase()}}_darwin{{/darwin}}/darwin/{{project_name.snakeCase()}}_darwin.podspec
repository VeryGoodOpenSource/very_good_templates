#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = '{{project_name.snakeCase()}}_darwin'
  s.version          = '0.0.1'
  s.summary          = 'The iOS and macOS implementation of the {{project_name.snakeCase()}} plugin.'
  s.description      = <<-DESC
  The iOS and macOS implementation of the {{project_name.snakeCase()}} plugin.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :type => 'BSD', :file => '../LICENSE' }
  s.author           = { '{{org_name.titleCase()}}' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = '{{project_name.snakeCase()}}_darwin/Sources/**/*.swift'
{{#ios}}  s.ios.dependency 'Flutter'
  s.ios.deployment_target = '13.0'
{{/ios}}{{#macos}}  s.osx.dependency 'FlutterMacOS'
  s.osx.deployment_target = '10.15'
{{/macos}}  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
  s.swift_version = '6.1'
end
