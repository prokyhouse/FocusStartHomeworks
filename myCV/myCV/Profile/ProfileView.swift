//
//  ProfileView.swift
//  myCV
//
//  Created by Кирилл Прокофьев on 11.11.2021.
//

import Foundation
import UIKit

class ProfileView: UIView {

	struct ProfileContent {
		internal let name: String
		internal let bio: String
		internal let interestsTitle: String
		internal let interests: String
		internal let mainInfoTitle: String
		internal let mainInfo: String
		internal let skillsTitle: String
		internal let skills: String

		internal init() {
			self.name = "Кирилл Прокофьев"
			self.bio = "21 год, г. Новосибирск"
			self.interestsTitle = "Интересы"
			self.mainInfoTitle = "О себе"
			self.skillsTitle = "Навыки разработчика"
			self.interests = """
Фотография, дизайн, IT, бизнес, учёба, котики
Фотография, дизайн, IT, бизнес, учёба, котики
Фотография, дизайн, IT, бизнес, учёба, котики
"""
			self.mainInfo = """
Фотография, дизайн, IT, бизнес, учёба, котики
"""
			self.skills = """
Фотография, дизайн, IT, бизнес, учёба, котики
"""
		}
	}


	private let contentView = UIView()
	private let scrollView = UIScrollView()
	private let profileCardView = UIView()
	private let nameLabel = UILabel()
	private let bioLabel = UILabel()
	private let avatar = UIImageView()
	private let mainBlock = DescriptionView()
	private let interestsBlock = DescriptionView()
	private let skillsBlock = DescriptionView()

	public override init(frame: CGRect) {
		super.init(frame: frame)
		self.configure()
	}

	public required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	internal func setContent(model: ProfileContent) {
		self.nameLabel.text = model.name
		self.bioLabel.text = model.bio
		self.mainBlock.setContent(model: DescriptionView.DescriptionContent(model: informationBlock(title: model.mainInfoTitle, description: model.mainInfo)))
		self.interestsBlock.setContent(model: DescriptionView.DescriptionContent(model: informationBlock(title: model.interestsTitle, description: model.interests)))
		self.skillsBlock.setContent(model: DescriptionView.DescriptionContent(model: informationBlock(title: model.skillsTitle, description: model.skills)))
	}

	private func configure() {
		self.setConfig()
		self.setContent(model: ProfileContent.init())
		self.addSubviews()
		self.setConstraints()
	}

	private func addSubviews() {
		self.addSubview(self.scrollView)
		self.scrollView.addSubview(self.contentView)

		self.contentView.addSubview(self.profileCardView)
		self.profileCardView.addSubview(self.nameLabel)
		self.profileCardView.addSubview(self.bioLabel)
		self.profileCardView.addSubview(self.avatar)
		self.contentView.addSubview(self.mainBlock)
		self.contentView.addSubview(self.interestsBlock)
		self.contentView.addSubview(self.skillsBlock)
	}

	private func setConfig() {
		self.backgroundColor = UIColor.white
		

		self.profileCardView.backgroundColor = UIColor.init(hex: "F5F5F5")
		self.profileCardView.layer.cornerRadius = 10

		self.nameLabel.font = UIFont.Title.large
		self.nameLabel.textColor = UIColor.black
		self.nameLabel.adjustsFontSizeToFitWidth = true

		self.bioLabel.font = UIFont.Footnote.small
		self.bioLabel.textColor = UIColor.red
		self.bioLabel.adjustsFontSizeToFitWidth = true

		self.avatar.layer.cornerRadius = self.avatar.frame.size.width/2
		self.avatar.image = UIImage(named: "ProfileImage")
	}

	private func setConstraints() {

		scrollView.translatesAutoresizingMaskIntoConstraints = false
		let scrollViewConstraints = [
			scrollView.leftAnchor.constraint(equalTo: self.leftAnchor),
			scrollView.rightAnchor.constraint(equalTo: self.rightAnchor),
			scrollView.topAnchor.constraint(equalTo: self.topAnchor),
			scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
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

			profileCardView.widthAnchor.constraint(equalToConstant: 355),
			profileCardView.heightAnchor.constraint(equalToConstant: 71)
		]

		NSLayoutConstraint.activate(profileCardViewConstraints)

		mainBlock.translatesAutoresizingMaskIntoConstraints = false
		let mainBlockConstraints = [
			mainBlock.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
			mainBlock.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
			mainBlock.topAnchor.constraint(equalTo: self.profileCardView.bottomAnchor,constant: 9),
			mainBlock.bottomAnchor.constraint(equalTo: self.interestsBlock.topAnchor),

			mainBlock.widthAnchor.constraint(equalToConstant: 375),
			//mainBlock.heightAnchor.constraint(equalToConstant: 138)
		]

		NSLayoutConstraint.activate(mainBlockConstraints)

		interestsBlock.translatesAutoresizingMaskIntoConstraints = false
		let interestsBlockConstraints = [
			interestsBlock.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
			interestsBlock.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
			interestsBlock.topAnchor.constraint(equalTo: self.mainBlock.bottomAnchor,constant: 9),

			interestsBlock.widthAnchor.constraint(equalToConstant: 375),
			//interestsBlock.heightAnchor.constraint(equalToConstant: 138)
		]

		NSLayoutConstraint.activate(interestsBlockConstraints)

		skillsBlock.translatesAutoresizingMaskIntoConstraints = false
		let skillsBlockConstraints = [
			skillsBlock.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
			skillsBlock.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
			skillsBlock.topAnchor.constraint(equalTo: self.interestsBlock.bottomAnchor,constant: 9),

			skillsBlock.widthAnchor.constraint(equalToConstant: 375),
			//skillsBlock.heightAnchor.constraint(equalToConstant: 138)
		]

		NSLayoutConstraint.activate(skillsBlockConstraints)

		nameLabel.translatesAutoresizingMaskIntoConstraints = false
		let nameLabelConstraints = [
			nameLabel.leftAnchor.constraint(equalTo: self.profileCardView.leftAnchor,constant: 75),
			nameLabel.rightAnchor.constraint(equalTo: self.profileCardView.rightAnchor,constant: -30),
			nameLabel.topAnchor.constraint(equalTo: self.profileCardView.topAnchor,constant: 18),
			nameLabel.bottomAnchor.constraint(equalTo: self.profileCardView.bottomAnchor,constant: -31),

			nameLabel.widthAnchor.constraint(equalToConstant: 26),
			nameLabel.heightAnchor.constraint(equalToConstant: 250)
		]

		NSLayoutConstraint.activate(nameLabelConstraints)

		bioLabel.translatesAutoresizingMaskIntoConstraints = false
		let bioLabelConstraints = [
			bioLabel.leftAnchor.constraint(equalTo: self.profileCardView.leftAnchor,constant: 75),
			bioLabel.rightAnchor.constraint(equalTo: self.profileCardView.rightAnchor,constant: -30),
			bioLabel.topAnchor.constraint(equalTo: self.profileCardView.topAnchor,constant: 40),
			bioLabel.bottomAnchor.constraint(equalTo: self.profileCardView.bottomAnchor,constant: -15),

			bioLabel.widthAnchor.constraint(equalToConstant: 16),
			bioLabel.heightAnchor.constraint(equalToConstant: 250)
		]

		NSLayoutConstraint.activate(bioLabelConstraints)

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
