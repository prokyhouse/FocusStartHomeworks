//
//  SkillsViewController.swift
//  myCV
//
//  Created by Кирилл Прокофьев on 10.11.2021.
//

import Foundation
import UIKit

class SkillsViewController: UIViewController {
	private var skillsView: SkillsView = SkillsView()

	override func viewDidLoad() {
		super.viewDidLoad()
		//self.view.setGradientBackground(colorTop: .green, colorBottom: .blue, cornerRadius: 0)
	}
	
	override func loadView() {
		self.view = self.skillsView
	}



}
