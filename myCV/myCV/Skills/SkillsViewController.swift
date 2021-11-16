//
//  SkillsViewController.swift
//  myCV
//
//  Created by Кирилл Прокофьев on 10.11.2021.
//

import Foundation
import UIKit

final class SkillsViewController: UIViewController {
	private let skillsView = SkillsView()

	override func viewDidLoad() {
		super.viewDidLoad()
	}

	override func loadView() {
		self.view = self.skillsView
	}

}
