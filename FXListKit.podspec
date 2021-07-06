#
#  Be sure to run `pod spec lint FXListKit.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|
  spec.name         = "FXListKit"
  spec.version      = "1.0.0"
  spec.summary      = "A data-driven UICollectionView framework for building fast and flexible lists"
  spec.homepage     = "https://github.com/feixue299/FXListKit"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author             = { "wupengfei" => "1569485690@qq.com" }
  spec.source       = { :git => "https://github.com/feixue299/FXListKit.git", :tag => "#{spec.version}" }
  spec.default_subspec = "Core"
  spec.ios.deployment_target  = '9.0'
  spec.swift_version = '5.0'

  spec.subspec "Core" do |ss|
    ss.source_files  = "Sources/FXListKit/Core/", "Sources/FXListKit/internal/", "Sources/FXListKit/Utilities/", "Sources/FXListKit/Bridge/"
  end

  spec.subspec "Animation" do |ss|
    ss.source_files = "Sources/FXListKitAnimation/", "Sources/FXListKit/Core/", "Sources/FXListKit/internal/", "Sources/FXListKit/Utilities/"
    ss.dependency "DifferenceKit", "~> 1.1.5"
  end

end
