//
//  SceneDelegate.swift
//  BMICalculator
//
//  Created by Matthew Travers on 6/7/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    /// Configures and attaches the initial scene to the app's main window
    /// This method is called when a new scene session is created or restored
    ///
    /// ** Params:
    ///     - scene: The scene being created or connected to the app
    ///     - session: The session associated with the scene
    ///     - connectionOptions: The options used to configure the scene's connection
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        let vc = BMICalculatorVC() // Initial view controller
        window.rootViewController = vc
        self.window = window
        window.makeKeyAndVisible()
    }
}
