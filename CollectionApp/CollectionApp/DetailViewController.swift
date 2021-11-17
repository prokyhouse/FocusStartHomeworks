//
//  DetailViewController.swift
//  CollectionApp
//
//  Created by Кирилл Прокофьев on 17.11.2021.
//

import Foundation
import UIKit

final class DetailViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		self.configure()
	}

	private func configure() {
		self.title = "Details"
		self.view.backgroundColor = .systemBackground

		let label = UILabel()
		label.text = "SOME DETAILS"

		self.view.addSubview(label)
		label.pinToSuperviewCenter()
	}
}
