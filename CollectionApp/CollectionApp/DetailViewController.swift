//
//  DetailViewController.swift
//  CollectionApp
//
//  Created by Кирилл Прокофьев on 17.11.2021.
//

import Foundation
import UIKit

final class DetailViewController: UIViewController {
	var movie: Movie = Movie(title: "smth", overview: "text", genres: ["no genre"])
	private let detailView = DetailView()
	
	override func loadView() {
		detailView.setContent(model: movie)
		self.view = self.detailView
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		self.title = movie.title
		//self.configure()
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
