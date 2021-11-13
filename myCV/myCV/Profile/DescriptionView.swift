//
//  DescriptionView.swift
//  myCV
//
//  Created by Кирилл Прокофьев on 11.11.2021.
//

import Foundation
import UIKit

class DescriptionView: UIView {

	struct DescriptionContent {
		internal let title: String
		internal let description: String

		internal init(model: InformationBlock) {
			self.title = model.title
			self.description = model.description
		}
	}

	private let descriptionLabelMinHeight = CGFloat(22)
	private var opened = false

	private let descriptionLabel: UILabel = UILabel()
	private let descriptionTitle: UILabel = UILabel()
	private let arrowImage: UIButton = UIButton()
	private let separator: UIView = UIView()

	override func awakeFromNib() {
		super.awakeFromNib()
		self.toggleTextHeight()
	}

	public override init(frame: CGRect) {
		super.init(frame: frame)
		self.configure()
	}

	public required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func configure() {
		self.addSubviews()
		self.setConstraints()
		self.setConfig()
	}

	private func addSubviews() {
		self.addSubview(self.descriptionTitle)
		self.addSubview(self.descriptionLabel)
		self.addSubview(self.arrowImage)
		self.addSubview(self.separator)
	}

	internal func setContent(model: DescriptionContent) {
		self.descriptionTitle.text = model.title
		self.descriptionLabel.text = model.description
	}

	private func setConfig() {
		self.separator.backgroundColor = UIColor.init(hex: "F5F5F5")

		self.arrowImage.setImage(UIImage(systemName: "chevron.down"),
								 for: .normal)
		self.arrowImage.setImage(UIImage(systemName: "chevron.up"),
								 for: .selected)
		self.arrowImage.addTarget(self, action:#selector(self.buttonTapped),
								  for: .touchUpInside)

		self.descriptionTitle.font = UIFont.Title.medium
		self.descriptionTitle.numberOfLines = 1
		self.descriptionTitle.adjustsFontSizeToFitWidth = true

		self.descriptionLabel.numberOfLines = 50
	}

	var descriptionLabelConstraints : [NSLayoutConstraint] = []

	private func setConstraints() {

		descriptionTitle.translatesAutoresizingMaskIntoConstraints = false
		let descriptionTitleConstraints = [
			descriptionTitle.heightAnchor.constraint(equalToConstant: 26),

			descriptionTitle.topAnchor.constraint(equalTo: self.topAnchor,
												  constant: 16),
			descriptionTitle.leftAnchor.constraint(equalTo: self.leftAnchor,
												   constant: 9),
			descriptionTitle.rightAnchor.constraint(equalTo: self.arrowImage.leftAnchor,
													constant: -16),
			descriptionTitle.bottomAnchor.constraint(equalTo: self.descriptionLabel.topAnchor,constant: -16)
		]

		NSLayoutConstraint.activate(descriptionTitleConstraints)

		descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
		descriptionLabelConstraints = [
			descriptionLabel.widthAnchor.constraint(equalTo: self.descriptionTitle.widthAnchor),
			descriptionLabel.heightAnchor.constraint(equalToConstant: descriptionLabelMinHeight),


			descriptionLabel.leftAnchor.constraint(equalTo: self.descriptionTitle.leftAnchor),
			descriptionLabel.rightAnchor.constraint(equalTo: self.descriptionTitle.rightAnchor),
			descriptionLabel.topAnchor.constraint(equalTo: self.descriptionTitle.bottomAnchor,
												  constant: 16)
		]

		NSLayoutConstraint.activate(descriptionLabelConstraints)

		arrowImage.translatesAutoresizingMaskIntoConstraints = false
		let arrowImageConstraints = [
			arrowImage.widthAnchor.constraint(equalTo: self.descriptionTitle.heightAnchor),
			arrowImage.heightAnchor.constraint(equalTo: self.descriptionTitle.heightAnchor),

			arrowImage.topAnchor.constraint(equalTo: self.topAnchor,
											constant: 20),
			arrowImage.rightAnchor.constraint(equalTo: self.rightAnchor,
											  constant: -16),

		]

		NSLayoutConstraint.activate(arrowImageConstraints)

		separator.translatesAutoresizingMaskIntoConstraints = false
		let separatorConstraints = [
			separator.heightAnchor.constraint(equalToConstant: 1),
			separator.topAnchor.constraint(equalTo: self.bottomAnchor),
			separator.rightAnchor.constraint(equalTo: self.rightAnchor,constant: -9),
			separator.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 9)
		]

		NSLayoutConstraint.activate(separatorConstraints)

		let descriptionViewConstraints = [
			self.widthAnchor.constraint(equalToConstant: 375),
			self.bottomAnchor.constraint(equalTo: self.descriptionLabel.bottomAnchor,constant: 16),
			self.topAnchor.constraint(equalTo: self.descriptionTitle.topAnchor,constant: -16)
		]

		NSLayoutConstraint.activate(descriptionViewConstraints)
	}
}

extension DescriptionView {

	@objc func buttonTapped() {
		self.opened = !self.opened
		self.drawViewState(opened: self.opened)
	}
}

private extension DescriptionView {

	func drawViewState(opened: Bool) {
		let angle = Double.pi / (opened ? 2 : -2)
		self.arrowImage.transform = self.arrowImage.transform.rotated(by: CGFloat(angle))
		self.toggleTextHeight()
	}
	
	func toggleTextHeight() {
		let height: CGFloat = {
			if self.opened {
				let constraints = CGSize(width: self.descriptionLabel.frame.width,
										 height: .greatestFiniteMagnitude)
				let size = self.descriptionLabel.sizeThatFits(constraints)
				return size.height+1
			} else {
				return self.descriptionLabelMinHeight
			}
		}()

		UIView.animate(withDuration: 0.3) {
			let fullDescriptionLabelConstraints = [
				self.descriptionLabel.widthAnchor.constraint(equalTo: self.descriptionTitle.widthAnchor),
				self.descriptionLabel.heightAnchor
					.constraint(equalToConstant: height),
				self.descriptionLabel.leftAnchor.constraint(equalTo: self.descriptionTitle.leftAnchor),
				self.descriptionLabel.rightAnchor.constraint(equalTo: self.descriptionTitle.rightAnchor),
				self.descriptionLabel.topAnchor.constraint(equalTo: self.descriptionTitle.bottomAnchor, constant: 16)
			]
			if self.opened {

				NSLayoutConstraint.deactivate(self.descriptionLabelConstraints)
				NSLayoutConstraint.activate(fullDescriptionLabelConstraints)
			} else {
				NSLayoutConstraint.activate(self.descriptionLabelConstraints)
				NSLayoutConstraint.deactivate(fullDescriptionLabelConstraints)
			}
		}
	}
}
