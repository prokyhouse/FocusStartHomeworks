//
//  TabBarController.swift
//  CollectionApp
//
//  Created by Кирилл Прокофьев on 17.11.2021.
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
		let filmsListVC = FilmsListViewController()

		filmsListVC.tabBarItem = self.createFilmsListTab()

		viewControllers = [filmsListVC]
		self.viewControllers = viewControllers
	}

	func createFilmsListTab() -> UITabBarItem {
		let item = UITabBarItem(title: "Фильмы", image: UIImage(systemName: "film"), tag: 0)
		return item
	}
}

