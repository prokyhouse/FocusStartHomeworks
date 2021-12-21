//
//  ViewController.swift
//  Workers
//
//  Created by Кирилл Прокофьев on 18.12.2021.
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
		let companiesVC = CompaniesViewController()
		let companiesNavVC = UINavigationController(rootViewController: companiesVC)
		companiesVC.tabBarItem = self.createCompaniesTab()
		viewControllers = [companiesNavVC]
		self.viewControllers = viewControllers
	}

	func createCompaniesTab() -> UITabBarItem {
		let item = UITabBarItem(title: "Компании", image: UIImage(systemName: "person.3.fill"), tag: 0)
		return item
	}
}
