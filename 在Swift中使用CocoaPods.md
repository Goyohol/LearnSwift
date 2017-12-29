#在Swift中使用CocoaPods

[]()
安装cocoaPods，参考：https://www.jianshu.com/p/0f74ee57a22a


[ ]( )
[ ]( )
先在终端，打开工程路径：“`cd 工程路径`”！
再输入“`pod init`”安装好cocoapods！便有了Podfile文件！
[ ]( )
[ ]( )
使用Podfile文件
	# Uncomment the next line to define a global platform for your project
	# platform :ios, '9.0'
	platform :ios, "8.0"  #平台信息

	target 'swiftUse' do
	  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
	  use_frameworks! #去掉注释 #使用的三方库

	pod 'Alamofire'
	pod 'MBProgressHUD'



 	 # Pods for swiftUse

 	 target 'swiftUseTests' do
 	   inherit! :search_paths
	    # Pods for testing
	  end

	end
    
[ ]( )
对于“`#use_frameworks!`” 去掉注释("#")

以“`pod 'Alamofire'`”形式，填写需要导入的三方库！



[ ]( )
[ ]( )

处理完Podfile文件后：
在进行“`pod install`”操作，安装需要的三方库！

[ ]( )



