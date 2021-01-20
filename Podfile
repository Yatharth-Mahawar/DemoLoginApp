# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'LoginDemo' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for LoginDemo
	pod 'Firebase/Analytics'
  pod 'Firebase/Firestore'
	pod 'Firebase/Auth'
	pod 'Firebase/Core'
  pod 'Firebase/Database'
	

  # Optionally, include the Swift extensions if you're using Swift.

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
    end
  end
end
