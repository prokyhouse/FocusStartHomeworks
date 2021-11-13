//
//  SceneDelegate.swift
//  myCV
//
//  Created by Кирилл Прокофьев on 10.11.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?

	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		if let scene = scene as? UIWindowScene {
			let window = UIWindow(windowScene: scene)
			let tabs = self.createTabs()
			window.rootViewController = tabs
			self.window = window
			self.window?.makeKeyAndVisible()
		}
	}
}


private extension SceneDelegate {
	func createTabs() -> UITabBarController {
		let tabBar = UITabBarController()
		let profileVC = ProfileViewController()
		let skillsVC = SkillsViewController()
		let hobbyVC = HobbyViewController()
		profileVC.tabBarItem = self.createProfileTab()
		skillsVC.tabBarItem = self.createSkillsTab()
		hobbyVC.tabBarItem = self.createHobbyTab()

		tabBar.setViewControllers([profileVC, skillsVC, hobbyVC], animated: false)
		return tabBar
	}

	func createProfileTab() -> UITabBarItem {
		let item = UITabBarItem(title: "Профиль", image: UIImage(systemName: "person.circle"), tag: 0)
		return item
	}

	func createSkillsTab() -> UITabBarItem {
		let item = UITabBarItem(title: "Скиллы", image: UIImage(systemName: "command"), tag: 1)
		return item
	}

	func createHobbyTab() -> UITabBarItem {
		let item = UITabBarItem(title: "Хобби", image: UIImage(systemName: "camera.filters"), tag: 2)
		return item
	}
}
