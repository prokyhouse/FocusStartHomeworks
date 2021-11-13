//
//  HobbyViewController.swift
//  myCV
//
//  Created by Кирилл Прокофьев on 13.11.2021.
//

import Foundation
import UIKit

protocol IHobbyViewController {
	func presentShareSheet(url: String)
}

class HobbyViewController: UIViewController, IHobbyViewController {
	private var hobbyView: HobbyView = HobbyView()

	override func viewDidLoad() {
		super.viewDidLoad()
		self.hobbyView.instagramButton.addTarget(self, action: #selector(shareInstagram), for: .touchUpInside)
	}

	override func loadView() {
		self.view = self.hobbyView
	}

	@IBAction func shareInstagram(_ sender: Any) {
		self.presentShareSheet(url: "https://instagram.com/prokofyev.k")
	}

	internal func presentShareSheet(url: String) {
		guard let url = URL(string: url) else {
			return
		}
		let shareSheetVC = UIActivityViewController(
			activityItems: [url],
			applicationActivities: nil)
		self.present(shareSheetVC, animated: true)
	}
}
