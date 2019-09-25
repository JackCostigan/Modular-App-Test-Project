#Podfile
use_frameworks!
workspace 'test-app.xcworkspace'

# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

def pods_test
  pod 'Quick'
  pod 'Nimble'
end

target 'test-app' do
  project 'test-app/test-app.xcodeproj'
  pod 'ReSwift'
end

target 'ModuleA' do
  project 'ModuleA/ModuleA.xcodeproj'
  pod 'ReSwift'
end

target 'ModuleB' do
  project 'ModuleB/ModuleB.xcodeproj'
end

