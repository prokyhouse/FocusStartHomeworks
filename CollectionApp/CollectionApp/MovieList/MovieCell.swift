//
//  FilmCell.swift
//  CollectionApp
//
//  Created by Кирилл Прокофьев on 17.11.2021.
//

import Foundation
import UIKit
import SnapKit

final class MovieCell: UICollectionViewCell {
	static let identifier = "FilmCell"

	private let imageView = UIImageView()
	private let nameLabel = UILabel()
	private let placeLabel = UILabel()

	var movie: Movie? {
		didSet {
			guard let movie = movie else { return }
			self.imageView.image = UIImage(named: movie.title)
			self.imageView.clipsToBounds = true
			self.nameLabel.text = movie.title
			self.placeLabel.text = movie.overview
		}
	}

	override var isHighlighted: Bool {
		didSet {
			UIView.animate(withDuration: 0.25) {
				self.alpha = self.isHighlighted ? 0.5 : 1.0
			}
		}
	}

	override init(frame: CGRect) {
		super.init(frame: frame)
		self.configure()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func configure() {
		self.setConfig()
		self.addSubviews()
		self.setConstraints()
	}

	private func setConfig() {
		self.imageView.contentMode = .scaleAspectFill
		self.imageView.clipsToBounds = true
		self.placeLabel.textColor = .lightGray
		self.placeLabel.numberOfLines = 2
		self.nameLabel.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.semibold)
		self.backgroundColor = .darkGray
		self.nameLabel.textColor = .white

		self.imageView.layer.cornerRadius = 12
		self.layer.cornerRadius = 10
	}

	private func addSubviews() {
		self.addSubview(imageView)
		self.addSubview(nameLabel)
		self.addSubview(placeLabel)
	}

	private func setConstraints() {

		self.imageView.snp.makeConstraints { make in
			make.left.top.bottom.equalToSuperview().inset(9)
			make.width.equalTo(95)
		}
		self.nameLabel.snp.makeConstraints { make in
			make.top.right.equalToSuperview().inset(9)
			make.left.equalTo(self.imageView.snp.right).offset(9)
		}
		self.placeLabel.snp.makeConstraints { make in
			make.right.equalToSuperview().inset(9)
			make.left.equalTo(self.imageView.snp.right).offset(9)
			make.top.equalTo(self.nameLabel.snp.bottom).offset(3)
		}
	}
}
