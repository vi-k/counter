import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        let channel = FlutterMethodChannel(name: "counter",
                                           binaryMessenger: controller.binaryMessenger)
        let _ = VolumeButtonsManager(application: application, channel: channel)

        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}

@objc public protocol UIApplicationPrivate {
    @objc func setWantsVolumeButtonEvents(_:Bool)
}

class VolumeButtonsManager {
    let application: UIApplication
    let channel: FlutterMethodChannel
    private var observer: NSObjectProtocol?

    init(application: UIApplication, channel: FlutterMethodChannel) {
        self.application = application
        self.channel = channel

        NotificationCenter.default.addObserver(forName: NSNotification.Name("_UIApplicationVolumeUpButtonDownNotification"),
                                                          object: nil,
                                                          queue: OperationQueue.main,
                                                          using: handleEventUpDown)
        NotificationCenter.default.addObserver(forName: NSNotification.Name("_UIApplicationVolumeUpButtonUpNotification"),
                                                          object: nil,
                                                          queue: OperationQueue.main,
                                                          using: handleEventUpUp)
        NotificationCenter.default.addObserver(forName: NSNotification.Name("_UIApplicationVolumeDownButtonDownNotification"),
                                                          object: nil,
                                                          queue: OperationQueue.main,
                                                          using: handleEventDownDown)
        NotificationCenter.default.addObserver(forName: NSNotification.Name("_UIApplicationVolumeDownButtonUoNotification"),
                                                          object: nil,
                                                          queue: OperationQueue.main,
                                                          using: handleEventDownUp)


        let application = unsafeBitCast(self.application, to:UIApplicationPrivate.self)
        application.setWantsVolumeButtonEvents(true)
    }

    deinit {
        NotificationCenter.default.removeObserver(observer!)
    }

    private func handleEventUpDown(_ notification: Notification) {
        channel.invokeMethod("onVolumeUpButtonDown", arguments: nil)
    }

    private func handleEventUpUp(_ notification: Notification) {
        channel.invokeMethod("onVolumeUpButtonUp", arguments: nil)
    }

    private func handleEventDownDown(_ notification: Notification) {
        channel.invokeMethod("onVolumeDownButtonDown", arguments: nil)
    }

    private func handleEventDownUp(_ notification: Notification) {
        channel.invokeMethod("onVolumeDownButtonUp", arguments: nil)
    }
}
