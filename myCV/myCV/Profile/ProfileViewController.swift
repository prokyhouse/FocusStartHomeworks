//
//  ProfileViewController.swift
//  myCV
//
//  Created by Кирилл Прокофьев on 10.11.2021.
//

import Foundation
import UIKit

final class ProfileViewController: UIViewController {
	private let profileView = ProfileView()

	override func viewDidLoad() {
		super.viewDidLoad()
	}
	override func loadView() {
		self.view = self.profileView
	}
}
