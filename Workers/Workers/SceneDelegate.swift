//
//  SceneDelegate.swift
//  Workers
//
//  Created by Кирилл Прокофьев on 18.12.2021.
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
	}
}
