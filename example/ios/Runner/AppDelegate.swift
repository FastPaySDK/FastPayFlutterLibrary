import UIKit
import app_links
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
      ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)

        // Retrieve the link from parameters
        if let url = AppLinks.shared.getLink(launchOptions: launchOptions) {
          // We have a link, propagate it to your Flutter app or not
          AppLinks.shared.handleLink(url: url)
          return true // Returning true will stop the propagation to other packages
        }
          print("Received URL:-0---------")
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
      }
    
    override func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        // Handle the URL here
        print("Received URL: \(url)")
        return true
    }
    





}

