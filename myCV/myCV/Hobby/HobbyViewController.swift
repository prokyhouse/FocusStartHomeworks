//
//  HobbyViewController.swift
//  myCV
//
//  Created by Кирилл Прокофьев on 13.11.2021.
//

import Foundation
import UIKit

class HobbyViewController: UIViewController {
	private var hobbyView: HobbyView = HobbyView()

	override func viewDidLoad() {
		super.viewDidLoad()
	}
	override func loadView() {
		self.view = self.hobbyView
	}
}
