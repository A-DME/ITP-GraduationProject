# Uncomment the next line to define a global platform for your project
platform :ios, '12.0'
post_install do |installer|
    installer.generated_projects.each do |project|
        project.targets.each do |target|
            target.build_configurations.each do |config|
                config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
            end
        end
    end
end
use_frameworks!

target 'E-CommerceApp' do
  # Comment the next line if you don't want to use dynamic frameworks
  pod 'Kingfisher', '~> 7.0'
  pod 'lottie-ios'
  pod 'Alamofire'  
use_frameworks!

  # Pods for E-CommerceApp

  target 'E-CommerceAppTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'E-CommerceAppUITests' do
    # Pods for testing
  end

end
