


import Foundation
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
	var window: UIWindow?
	
	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let windowScene = (scene as? UIWindowScene) else { return }
		
		let window = UIWindow(windowScene: windowScene)
		self.window = window
		 
		let usersViewController: UsersViewController = Storyboard.user.getViewController()
		let usersNavigationController = BaseNavigationController(rootViewController: usersViewController)
		window.rootViewController = usersNavigationController
		window.makeKeyAndVisible()
	}
	
	func sceneDidDisconnect(_ scene: UIScene) {
		// Called as the scene is being released by the system.
	}
	
	func sceneDidBecomeActive(_ scene: UIScene) {
		// Not called under iOS 12 - See AppDelegate applicationDidBecomeActive
	}
	
	func sceneWillResignActive(_ scene: UIScene) {
		// Not called under iOS 12 - See AppDelegate applicationWillResignActive
	}
	
	func sceneWillEnterForeground(_ scene: UIScene) {
		// Not called under iOS 12 - See AppDelegate applicationWillEnterForeground
	}
	
	func sceneDidEnterBackground(_ scene: UIScene) {
		// Not called under iOS 12 - See AppDelegate applicationDidEnterBackground
	}
}
