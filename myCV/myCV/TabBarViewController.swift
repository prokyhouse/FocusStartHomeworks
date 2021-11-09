//
//  TabBarViewController.swift
//  myCV
//
//  Created by Кирилл Прокофьев on 09.11.2021.
//

import Foundation
import UIKit

class TabBarViewController: UITabBarController {
	override func viewDidLoad() {
		super.viewDidLoad()
		self.tabBar.tintColor = UIColor(named: "RedTint")
	}

	func set(viewControllers: [UIViewController]) {
		self.viewControllers = viewControllers
	}
}
