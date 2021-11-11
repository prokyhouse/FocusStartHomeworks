//
//  TabBarController.swift
//  myCV
//
//  Created by Кирилл Прокофьев on 10.11.2021.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {
	override func viewDidLoad() {
		super.viewDidLoad()
	}

	func set(viewControllers: [UIViewController]) {
		self.viewControllers = viewControllers
	}
}
