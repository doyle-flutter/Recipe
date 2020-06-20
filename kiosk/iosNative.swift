import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let callChannel = FlutterMethodChannel.init(name: "samples.flutter.dev/action",binaryMessenger: controller.binaryMessenger)

    callChannel.setMethodCallHandler { (call, result) in
        if(call.method == "callFunc"){
          if let args = call.arguments as? Dictionary<String, Any>{
              let callNumber:String! = args["number"] as? String
              self.callFunc(callNumber: callNumber)
              return
          }
          return
        }
        return
    }

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
  private func callFunc(callNumber:String){
      if let url = URL(string: "tel://\(callNumber)"), UIApplication.shared.canOpenURL(url) {
          if #available(iOS 10, *) {
              UIApplication.shared.open(url)
          } else {
              UIApplication.shared.openURL(url)
          }
      }
  }
}
