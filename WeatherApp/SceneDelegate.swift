import UIKit
import SwiftUI
import MapKit
import ComposableArchitecture

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        let contentView = ContentView(
          store: Store(
            initialState: AppState(),
            reducer: appReducer,
            environment: AppEnvironment(
              mainQueue: DispatchQueue.main.eraseToAnyScheduler()
            )
          )
        )
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}
