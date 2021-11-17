//
//  SceneDelegate.swift
//  CollectionApp
//
//  Created by Кирилл Прокофьев on 16.11.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?

	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		if let scene = scene as? UIWindowScene {
			let window = UIWindow(windowScene: scene)
			window.rootViewController = TabBarController()
			self.window = window
			self.window?.makeKeyAndVisible()
		}

		func sceneDidDisconnect(_ scene: UIScene) {
		}

		func sceneDidBecomeActive(_ scene: UIScene) {
		}

		func sceneWillResignActive(_ scene: UIScene) {
		}

		func sceneWillEnterForeground(_ scene: UIScene) {
		}

		func sceneDidEnterBackground(_ scene: UIScene) {
			(UIApplication.shared.delegate as? AppDelegate)?.saveContext()
		}
	}

}
