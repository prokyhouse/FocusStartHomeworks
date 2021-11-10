//
//  ProfileViewController.swift
//  myCV
//
//  Created by Кирилл Прокофьев on 10.11.2021.
//

import Foundation
import UIKit

class ProfileViewController: UIViewController {

	private let contentView = UIView()
	private let scrollView = UIScrollView()
	private let profileCardView = UIView()
	private let nameLabel = UILabel()
	private let emailLabel = UILabel()
	private let avatar = UIImageView()

	override func viewDidLoad() {
		super.viewDidLoad()
		self.configure()
	}

	private func configure() {
		self.setConfig()
		self.setContent()
		self.addSubviews()
		self.setConstraints()
	}

	private func addSubviews() {
		self.view.addSubview(self.scrollView)
		self.scrollView.addSubview(self.contentView)

		self.contentView.addSubview(self.profileCardView)
		self.profileCardView.addSubview(self.nameLabel)
		self.profileCardView.addSubview(self.emailLabel)
		self.profileCardView.addSubview(self.avatar)
	}

	private func setContent() {
		self.nameLabel.text = "Кирилл Прокофьев"
		self.emailLabel.text = "k.prokofev1@g.nsu.ru"
	}

	private func setConfig() {
		self.profileCardView.backgroundColor = UIColor.lightGray
		self.profileCardView.layer.cornerRadius = 10

		self.nameLabel.font = UIFont.Title.medium
		self.nameLabel.textColor = UIColor.black
		self.nameLabel.adjustsFontSizeToFitWidth = true

		self.emailLabel.font = UIFont.Footnote.small
		self.emailLabel.textColor = UIColor.red
		self.emailLabel.adjustsFontSizeToFitWidth = true

		self.avatar.layer.cornerRadius = self.avatar.frame.size.width/2
		self.avatar.image = UIImage(named: "ProfileImage")
	}

	private func setConstraints() {

		scrollView.translatesAutoresizingMaskIntoConstraints = false
		let scrollViewConstraints = [
			scrollView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
			scrollView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
			scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
			scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
		]

		NSLayoutConstraint.activate(scrollViewConstraints)

		contentView.translatesAutoresizingMaskIntoConstraints = false
		let contentViewConstraints = [
			contentView.leftAnchor.constraint(equalTo: self.scrollView.leftAnchor),
			contentView.rightAnchor.constraint(equalTo: self.scrollView.rightAnchor),
			contentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
			contentView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor,constant: -40),

			contentView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor),
			contentView.heightAnchor.constraint(equalTo: self.scrollView.heightAnchor)
		]

		NSLayoutConstraint.activate(contentViewConstraints)

		profileCardView.translatesAutoresizingMaskIntoConstraints = false
		let profileCardViewConstraints = [
			profileCardView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor,constant: 9),
			profileCardView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor,constant: -9),
			profileCardView.topAnchor.constraint(equalTo: self.contentView.topAnchor,constant: 9),

			contentView.widthAnchor.constraint(equalToConstant: 355),
			contentView.heightAnchor.constraint(equalToConstant: 71)
		]

		NSLayoutConstraint.activate(profileCardViewConstraints)

		nameLabel.translatesAutoresizingMaskIntoConstraints = false
		let nameLabelConstraints = [
			nameLabel.leftAnchor.constraint(equalTo: self.profileCardView.leftAnchor,constant: 75),
			nameLabel.rightAnchor.constraint(equalTo: self.profileCardView.rightAnchor,constant: -30),
			nameLabel.topAnchor.constraint(equalTo: self.profileCardView.topAnchor,constant: 18),
			nameLabel.bottomAnchor.constraint(equalTo: self.profileCardView.bottomAnchor,constant: -31),

			nameLabel.widthAnchor.constraint(equalToConstant: 22),
			nameLabel.heightAnchor.constraint(equalToConstant: 250)
		]

		NSLayoutConstraint.activate(nameLabelConstraints)

		emailLabel.translatesAutoresizingMaskIntoConstraints = false
		let emailLabelConstraints = [
			emailLabel.leftAnchor.constraint(equalTo: self.profileCardView.leftAnchor,constant: 75),
			emailLabel.rightAnchor.constraint(equalTo: self.profileCardView.rightAnchor,constant: -30),
			emailLabel.topAnchor.constraint(equalTo: self.profileCardView.topAnchor,constant: 40),
			emailLabel.bottomAnchor.constraint(equalTo: self.profileCardView.bottomAnchor,constant: -15),

			emailLabel.widthAnchor.constraint(equalToConstant: 16),
			emailLabel.heightAnchor.constraint(equalToConstant: 250)
		]

		NSLayoutConstraint.activate(emailLabelConstraints)

		avatar.translatesAutoresizingMaskIntoConstraints = false
		let avatarConstraints = [
			avatar.leftAnchor.constraint(equalTo: self.profileCardView.leftAnchor,constant: 19),
			avatar.topAnchor.constraint(equalTo: self.profileCardView.topAnchor,constant: 13),
			avatar.bottomAnchor.constraint(equalTo: self.profileCardView.bottomAnchor,constant: -13),

			avatar.widthAnchor.constraint(equalToConstant: 45),
			avatar.heightAnchor.constraint(equalToConstant: 45)
		]

		NSLayoutConstraint.activate(avatarConstraints)
	}
}
