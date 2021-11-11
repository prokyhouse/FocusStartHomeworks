//
//  SkillsViewController.swift
//  myCV
//
//  Created by Кирилл Прокофьев on 10.11.2021.
//

import Foundation
import UIKit

protocol ISkillsViewController: UIViewController {
}

class SkillsViewController: UIViewController, ISkillsViewController {

	init() {
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func loadView() {
	}

	override func viewDidLoad() {
		super.viewDidLoad()
	}

}
