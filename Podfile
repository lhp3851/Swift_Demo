# Uncomment the next line to define a global platform for your project

#source 'http://gitlab.lhp.com:9090/iOS/JProjects.git'
source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '10.0'
inhibit_all_warnings!

target 'Swift_Demo' do
  use_frameworks!

  #Base
  pod 'Frameworks_Swift'
  pod 'SwifterSwift', '~> 5.0.0'
  pod 'Appz' # app Comunication
  pod 'PermissionScope' #APP权限管理
  #pod 'ReactiveCocoa', '~> 9.0'
  
  #NetWork
  #pod 'Moya', '~> 10.0.1'
  pod 'SwiftyStoreKit' #轻量级的APP内购框架
  pod 'ReachabilitySwift', git: 'https://github.com/ashleymills/Reachability.swift'
  
  #Datas
  #pod 'XCGLogger', '~> 7.0.0'
  pod 'CocoaLumberjack/Swift'
  #pod 'SQLite.swift', '~> 0.12.0'
  pod 'SwiftyJSON'
  pod 'RealmSwift'
  
  #UI
  pod 'Texture'
  pod 'Charts'
  pod 'NVActivityIndicatorView'
  pod 'MBProgressHUD', '~> 1.0.0'
  pod 'SDCycleScrollView','~> 1.80'
  pod 'Instructions', '~> 1.0.0' # instruction for freshmen
  pod 'lottie-ios'
  pod 'RAMAnimatedTabBarController', '~> 5.0.0'
  #pod 'PageMenu' #
  #pod 'SCLAlertView' #alert View
  #pod 'DOFavoriteButton'#有动画效果的button，适用于收藏、喜欢、点赞等
  #pod 'LTMorphingLabel'#Label
  
  #extend
  #pod 'BluetoothKit', '~> 0.2.0'#
  #pod 'RazzleDazzle' # keyframe-based animation
  
  target 'Swift_DemoTests' do
    inherit! :search_paths
  end

  target 'Swift_DemoUITests' do
    inherit! :search_paths
  end

end
