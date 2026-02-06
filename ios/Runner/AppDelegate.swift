import Flutter
import UIKit
import CoreTelephony

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let esimChannel = FlutterMethodChannel(name: "vink.sim/esim",
                                         binaryMessenger: controller.binaryMessenger)
    
    esimChannel.setMethodCallHandler({
      (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
      guard call.method == "installEsim" else {
        result(FlutterMethodNotImplemented)
        return
      }
      
      guard let args = call.arguments as? [String: Any],
            let smdpServer = args["smdpServer"] as? String,
            let activationCode = args["activationCode"] as? String else {
        result(FlutterError(code: "INVALID_ARGUMENTS", message: "Missing smdpServer or activationCode", details: nil))
        return
      }
      
      self.installEsimProfile(smdpServer: smdpServer, activationCode: activationCode, result: result)
    })
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
  
  private func installEsimProfile(smdpServer: String, activationCode: String, result: @escaping FlutterResult) {
    // Создаем URL для eSIM профиля
    let esimUrl = "LPA:1$\(smdpServer)$\(activationCode)"
    
    // Проверяем, доступен ли eSIM на устройстве
    guard #available(iOS 12.0, *) else {
      result(FlutterError(code: "UNSUPPORTED_VERSION", message: "eSIM requires iOS 12.0 or later", details: nil))
      return
    }
    
    // На iOS нет публичного API для прямой установки eSIM профилей
    // Единственный способ - открыть настройки или предложить пользователю вручную скопировать данные
    DispatchQueue.main.async {
      let alertController = UIAlertController(
        title: "Install eSIM Profile",
        message: "To install the eSIM profile, please:\n1. Go to Settings > Cellular > Add Cellular Plan\n2. Use the following details:\n\nSM-DP+ Server: \(smdpServer)\nActivation Code: \(activationCode)",
        preferredStyle: .alert
      )
      
      alertController.addAction(UIAlertAction(title: "Copy Server", style: .default) { _ in
        UIPasteboard.general.string = smdpServer
      })
      
      alertController.addAction(UIAlertAction(title: "Copy Code", style: .default) { _ in
        UIPasteboard.general.string = activationCode
      })
      
      alertController.addAction(UIAlertAction(title: "Open Settings", style: .default) { _ in
        if let settingsUrl = URL(string: UIApplication.openSettingsURLString) {
          UIApplication.shared.open(settingsUrl)
        }
      })
      
      alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
      
      if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
         let window = windowScene.windows.first {
        window.rootViewController?.present(alertController, animated: true)
      }
      
      result("success")
    }
  }
}
