//
//  TabBarController.swift
//  myCV
//
//  Created by Кирилл Прокофьев on 15.11.2021.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {

	override func viewDidLoad() {
		super.viewDidLoad()
		self.set()
	}

	func set() {
		let viewControllers: [UIViewController]
		let profileVC = ProfileViewController()
		let skillsVC = SkillsViewController()
		let hobbyVC = HobbyViewController()
		profileVC.tabBarItem = self.createProfileTab()
		skillsVC.tabBarItem = self.createSkillsTab()
		hobbyVC.tabBarItem = self.createHobbyTab()
		viewControllers = [profileVC, skillsVC, hobbyVC]
		self.viewControllers = viewControllers
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

