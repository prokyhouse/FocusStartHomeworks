//
//  SkillView.swift
//  myCV
//
//  Created by Кирилл Прокофьев on 12.11.2021.
//

import Foundation
import SnapKit
import UIKit

final class SkillView: UIView {

	struct SkillContent {
		 let logo: UIImage?
		 let title: String
		 let description: String
		 let since: String
		 let gradients: ColorGradient

		 init(skillModel: Skill) {
			self.logo = skillModel.logo
			self.title = skillModel.title
			self.description = skillModel.description
			self.since = skillModel.since
			self.gradients = skillModel.gradients

		}
	}
	 let logoImage = UIImageView()
	 let titleLabel = UILabel()
	 let descriptionLabel = UILabel()
	 let sinceLabel = UILabel()
	 var gradient = ColorGradient(colorTop: .systemRed, colorBottom: .systemIndigo)

	public override init(frame: CGRect) {
		super.init(frame: frame)
		self.configure()
	}

	public required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func layoutSubviews() {
		super.layoutSubviews()
		self.setGradientBackground(colorTop: gradient.colorTop, colorBottom: gradient.colorBottom, cornerRadius: 12)
	}

	private func configure() {
		self.setConfig()
		self.addSubviews()
		self.setConstraints()
	}

	private func setConfig() {

		self.titleLabel.font = UIFont.Title.large
		self.titleLabel.textColor = .white
		self.titleLabel.textAlignment = .center
		self.titleLabel.adjustsFontSizeToFitWidth = true

		self.descriptionLabel.font = UIFont.Callout.medium
		self.descriptionLabel.textColor = .white
		self.descriptionLabel.textAlignment = .left
		self.descriptionLabel.numberOfLines = 8
		self.descriptionLabel.lineBreakMode = NSLineBreakMode.byWordWrapping

		self.sinceLabel.textAlignment = .center
		self.sinceLabel.textColor = .white
		self.sinceLabel.adjustsFontSizeToFitWidth = true

		self.logoImage.tintColor = .white
			}

	 func setContent(model: SkillContent) {
		self.logoImage.image = model.logo
		self.titleLabel.text = model.title
		self.descriptionLabel.text = model.description
		self.sinceLabel.text = model.since
		self.gradient = model.gradients

	}

	private func addSubviews() {
		self.addSubview(self.logoImage)
		self.addSubview(self.titleLabel)
		self.addSubview(self.descriptionLabel)
		self.addSubview(self.sinceLabel)
	}

	private func setConstraints() {
		self.logoImage.snp.makeConstraints { make in
			make.height.width.equalTo(30)
			make.top.equalToSuperview().offset(13)
			make.centerX.equalTo(self)
		}

		self.titleLabel.snp.makeConstraints { make in
			make.height.lessThanOrEqualTo(25)
			make.top.equalTo(self.logoImage.snp.bottom).offset(13)
			make.left.right.equalToSuperview().inset(13)
		}

		self.descriptionLabel.snp.makeConstraints { make in
			make.left.right.equalToSuperview().inset(13)
			make.top.equalTo(self.titleLabel.snp.bottom).offset(13)
		}

		self.sinceLabel.snp.makeConstraints { make in
			make.height.equalTo(25)
			make.top.equalTo(self.descriptionLabel.snp.bottom).offset(13)
			make.left.right.equalToSuperview().inset(118)
		}

		self.snp.makeConstraints { make in
			make.bottom.equalTo(self.sinceLabel.snp.bottom).offset(13)
		}
	}
}
