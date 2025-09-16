#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = '{{project_name.snakeCase()}}_macos'
  s.version          = '0.0.1'
  s.summary          = 'A macOS implementation of the {{project_name.snakeCase()}} plugin.'
  s.description      = <<-DESC
  A macOS implementation of the {{project_name.snakeCase()}} plugin.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :type => 'BSD', :file => '../LICENSE' }
  s.author           = { '{{org_name.titleCase()}}' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = '{{project_name.snakeCase()}}_macos/Sources/**/*.swift'
  s.dependency 'FlutterMacOS'
  s.platform = :osx
  s.osx.deployment_target = '10.15'
  s.swift_version = '6.1'
end

