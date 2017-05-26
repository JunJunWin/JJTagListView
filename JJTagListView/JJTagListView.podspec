#
# Be sure to run `pod lib lint JJJTagListView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'JJTagListView'
  s.version          = '0.0.2'
  s.summary          = 'A easy way to implementation TagView'
  s.description      = <<-DESC
                         a simple tagView for iOS.
                       DESC
  s.homepage         = 'https://github.com/JunJunWin/JJTagListView'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'JunJunWin' => '420344796@qq.com' }
  s.source           = { :git => 'https://github.com/JunJunWin/JJTagListView.git', :tag => s.version }
  s.ios.deployment_target = '7.0'
  s.source_files = "JJTagListView/*.{h,m}"
end
