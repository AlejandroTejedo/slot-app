//
//  GoSlotNativaApp.swift
//  GoSlotNativa
//
//  Created by Alejandro on 24/10/21.
//

import SwiftUI
import Firebase
import GoogleSignIn

@main
struct GoSlotNativaApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    init () {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(AuthViewModel.shared)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate{
  /*  func application(_ application: UIApplication, didFinishLauchingWithOptions launchOptions:
                     [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
        
        return true
    }*/
    
    
    func application(_ application: UIApplication, open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any])
      -> Bool {
      return GIDSignIn.sharedInstance.handle(url)
      }
}
