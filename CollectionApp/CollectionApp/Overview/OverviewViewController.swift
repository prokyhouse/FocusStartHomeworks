//
//  OverviewViewController.swift
//  CollectionApp
//
//  Created by Кирилл Прокофьев on 17.11.2021.
//

import UIKit

final class OverviewViewController: UIViewController {

	var movie: Movie = Movie(title: "smth", overview: "text", genres: ["no genre"])

	private enum Metrics {
		static let spaceBetweenComponents: CGFloat = 9
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		self.configure()
	}

	private func configure() {
		self.view.backgroundColor = .systemBackground

		let action = UIAction(handler: { [weak self] _ in
			self?.dismiss(animated: true)
		})

		let closeButton = UIButton(type: .system, primaryAction: action)
		closeButton.setImage(.init(systemName: "xmark"), for: .normal)
		closeButton.tintColor = .label

		let label = UILabel()
		label.text = movie.overview
		label.numberOfLines = 40
		label.textAlignment = .center

		self.view.addSubview(closeButton)
		self.view.addSubview(label)

		label.snp.makeConstraints { make in
			make.left.right.equalToSuperview().inset(Metrics.spaceBetweenComponents)
		}

		closeButton.pin(edges: [.top(10), .left(10)], to: self.view)
		label.pinToSuperviewCenter()
	}
}
