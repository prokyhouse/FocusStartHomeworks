//
//  ProfileView.swift
//  myCV
//
//  Created by Кирилл Прокофьев on 11.11.2021.
//

import Foundation
import UIKit

final class ProfileView: UIView {

	private enum Metrics {
		static let spaceBetweenComponents: CGFloat = 9
		static let avatarSize: CGFloat = 45
		static let avatarPadding: CGFloat = 13
		static let cardTextLeftPadding: CGFloat = 75
		static let cardTextRightPadding: CGFloat = -30
		static let bottomSafeArea: CGFloat = -40
		static let viewHeight: CGFloat = 360
		static let profileCardHeight: CGFloat = 71
	}

	struct ProfileContent {
		 let name: String
		 let bio: String
		 let interestsTitle: String
		 let interests: String
		 let mainInfoTitle: String
		 let mainInfo: String
		 let skillsTitle: String
		 let skills: String

		 init() {
			self.name = "Кирилл Прокофьев"
			self.bio = "21 год, г. Новосибирск"
			self.interestsTitle = "Интересы"
			self.mainInfoTitle = "О себе"
			self.skillsTitle = "Навыки разработчика"
			self.interests = """
Фотография, дизайн мобильных приложений, IT, бизнес, учёба, котики.
"""
			self.mainInfo = """
• родился 23 мая 2000
• Неоконченное высшее образование (ФИТ НГУ, направление "CS and System Design")
• Профессиональный фотограф
• Дизайнер
• Android (Java) и iOS программист
• Предприниматель (владею брендом одежды)
• И просто НГУшник 🏄🏻‍♂️
"""
			self.skills = """
Имею опыт работы в команде над различными IT-проектами под iOS/Android и VR.
Постоянно обучаюсь, помимо учёбы в НГУ (на факультете информационных технологий), изучаю мобильную разработку, менеджмент и дизайн/прототипирование интерфейсов.
Имею практический опыт в менеджменте - на теущий момент работаю Middle Project manager'ом в Казанской IT-компании.
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

	private func configure() {
		self.setConfig()
		self.setContent(model: ProfileContent.init())
		self.addSubviews()
		self.setConstraints()
	}

	 func setContent(model: ProfileContent) {
		self.nameLabel.text = model.name
		self.bioLabel.text = model.bio
		self.mainBlock.setContent(model: DescriptionView.DescriptionContent(model: InformationBlock(title: model.mainInfoTitle,
																									description: model.mainInfo)))
		self.interestsBlock.setContent(model: DescriptionView.DescriptionContent(model: InformationBlock(title: model.interestsTitle,
																										 description: model.interests)))
		self.skillsBlock.setContent(model: DescriptionView.DescriptionContent(model: InformationBlock(title: model.skillsTitle,
																									  description: model.skills)))
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
		self.backgroundColor = UIColor(named: "Background")

		self.profileCardView.backgroundColor = UIColor(named: "Field")
		self.profileCardView.layer.cornerRadius = 10

		self.nameLabel.font = UIFont.Title.large
		self.nameLabel.adjustsFontSizeToFitWidth = true

		self.bioLabel.font = UIFont.Footnote.small
		self.bioLabel.textColor = UIColor(named: "AccentColor")
		self.bioLabel.adjustsFontSizeToFitWidth = true

		self.avatar.layer.cornerRadius = self.avatar.frame.size.width/2
		self.avatar.image = UIImage(named: "ProfileImage")
	}

	private func setConstraints() {

		scrollView.translatesAutoresizingMaskIntoConstraints = false
		let scrollViewConstraints = [
			scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
			scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
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
			contentView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor,
												constant: Metrics.bottomSafeArea),
			contentView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
			contentView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor),
			contentView.heightAnchor.constraint(equalTo: self.scrollView.heightAnchor,
												constant: Metrics.viewHeight)
		]

		NSLayoutConstraint.activate(contentViewConstraints)

		profileCardView.translatesAutoresizingMaskIntoConstraints = false
		let profileCardViewConstraints = [
			profileCardView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: Metrics.spaceBetweenComponents),
			profileCardView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -Metrics.spaceBetweenComponents),
			profileCardView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: Metrics.spaceBetweenComponents),
			profileCardView.heightAnchor.constraint(equalToConstant: Metrics.profileCardHeight)
		]

		NSLayoutConstraint.activate(profileCardViewConstraints)

		mainBlock.translatesAutoresizingMaskIntoConstraints = false
		let mainBlockConstraints = [
			mainBlock.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
			mainBlock.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
			mainBlock.topAnchor.constraint(equalTo: self.profileCardView.bottomAnchor, constant: Metrics.spaceBetweenComponents),
			mainBlock.bottomAnchor.constraint(equalTo: self.interestsBlock.topAnchor),
		]

		NSLayoutConstraint.activate(mainBlockConstraints)

		interestsBlock.translatesAutoresizingMaskIntoConstraints = false
		let interestsBlockConstraints = [
			interestsBlock.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
			interestsBlock.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
			interestsBlock.topAnchor.constraint(equalTo: self.mainBlock.bottomAnchor, constant: Metrics.spaceBetweenComponents),
		]

		NSLayoutConstraint.activate(interestsBlockConstraints)

		skillsBlock.translatesAutoresizingMaskIntoConstraints = false
		let skillsBlockConstraints = [
			skillsBlock.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
			skillsBlock.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
			skillsBlock.topAnchor.constraint(equalTo: self.interestsBlock.bottomAnchor,
											 constant: Metrics.spaceBetweenComponents),
		]

		NSLayoutConstraint.activate(skillsBlockConstraints)

		nameLabel.translatesAutoresizingMaskIntoConstraints = false
		let nameLabelConstraints = [
			nameLabel.leftAnchor.constraint(equalTo: self.profileCardView.leftAnchor,
											constant: Metrics.cardTextLeftPadding),
			nameLabel.rightAnchor.constraint(equalTo: self.profileCardView.rightAnchor,
											 constant: Metrics.cardTextRightPadding),
			nameLabel.topAnchor.constraint(equalTo: self.profileCardView.topAnchor,
										   constant: 18),
			nameLabel.bottomAnchor.constraint(equalTo: self.profileCardView.bottomAnchor,
											  constant: -31),
		]

		NSLayoutConstraint.activate(nameLabelConstraints)

		bioLabel.translatesAutoresizingMaskIntoConstraints = false
		let bioLabelConstraints = [
			bioLabel.leftAnchor.constraint(equalTo: self.profileCardView.leftAnchor,
										   constant: Metrics.cardTextLeftPadding),
			bioLabel.rightAnchor.constraint(equalTo: self.profileCardView.rightAnchor,
											constant: Metrics.cardTextRightPadding),
			bioLabel.topAnchor.constraint(equalTo: self.profileCardView.topAnchor,
										  constant: 40),
			bioLabel.bottomAnchor.constraint(equalTo: self.profileCardView.bottomAnchor,
											 constant: -15),
		]

		NSLayoutConstraint.activate(bioLabelConstraints)

		avatar.translatesAutoresizingMaskIntoConstraints = false
		let avatarConstraints = [
			avatar.leftAnchor.constraint(equalTo: self.profileCardView.leftAnchor, constant: Metrics.avatarPadding),
			avatar.topAnchor.constraint(equalTo: self.profileCardView.topAnchor, constant: Metrics.avatarPadding),
			avatar.bottomAnchor.constraint(equalTo: self.profileCardView.bottomAnchor, constant: -Metrics.avatarPadding),
			avatar.widthAnchor.constraint(equalToConstant: Metrics.avatarSize),
			avatar.heightAnchor.constraint(equalToConstant: Metrics.avatarSize)
		]

		NSLayoutConstraint.activate(avatarConstraints)
	}
}
