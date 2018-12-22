import Flutter
import UIKit

public class UIActivityIndicatorFactory : NSObject, FlutterPlatformViewFactory {

    var messenger: FlutterBinaryMessenger!

    public func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {
        return UIActivityIndicatorController(withFrame: frame, viewIdentifier: viewId, arguments: args, binaryMessenger: messenger)
    }

    @objc public init(messenger: (NSObject & FlutterBinaryMessenger)?) {
        super.init()
        self.messenger = messenger
    }

    public func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
        return FlutterStandardMessageCodec.sharedInstance()
    }
}

public class UIActivityIndicatorController: NSObject, FlutterPlatformView {

    fileprivate var viewId: Int64!;
    fileprivate var indicator: UIActivityIndicatorView!
    fileprivate var channel: FlutterMethodChannel!

    public init(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?, binaryMessenger: FlutterBinaryMessenger) {
        super.init()

        self.indicator = UIActivityIndicatorView()
        self.indicator.activityIndicatorViewStyle = .whiteLarge
        self.indicator.color = UIColor.red
        self.indicator.hidesWhenStopped = true

        let channelName = String(format: "plugins/activity_indicator", viewId)
        self.channel = FlutterMethodChannel(name: channelName, binaryMessenger: binaryMessenger)

        self.channel.setMethodCallHandler({
            [weak self]
            (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            if let this = self {
                this.onMethodCall(call: call, result: result)
            }
        })
    }

    public func view() -> UIView {
        return self.indicator
    }

    func onMethodCall(call: FlutterMethodCall, result: @escaping FlutterResult) {
        let method = call.method
        if method == "start" {
            self.indicator.startAnimating()
        } else if method == "stop" {
            self.indicator.stopAnimating()
        }
    }
}
