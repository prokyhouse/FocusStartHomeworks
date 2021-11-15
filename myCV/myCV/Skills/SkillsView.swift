//
//  SkillsView.swift
//  myCV
//
//  Created by Кирилл Прокофьев on 12.11.2021.
//

import Foundation
import SnapKit
import UIKit

class SkillsView: UIView {

	private enum Metrics {
		static let spaceBetweenComponents: CGFloat = 9
	}

	private let contentView = UIView()
	private let scrollView = UIScrollView()
	private let androidSkill = SkillView()
	private let iosSkill = SkillView()
	private let vrSkill = SkillView()
	private let otherSkills = SkillView()

	public override init(frame: CGRect) {
		super.init(frame: frame)
		self.configure()
	}

	public required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func configure() {
		self.setConfig()
		self.setContent()
		self.addSubviews()
		self.setConstraints()
	}

	private func setConfig() {
		self.backgroundColor = UIColor(named: "Background")
	}

	private func setContent() {
		self.androidSkill.setContent(model: SkillView.SkillContent(
			skillModel: Skill(logo: UIImage(named: "Android"),
							  title: "Android-разработка",
							  description: """
• окончил SAMSUNG IT SCHOOL в 2017
• Победитель конкурса проектов "SAMSUNG выбирает сильнейших" 2017
• Выпустил приложение в Google Play
""",
							  since: "с 2016 года",
							  gradients:
								ColorGradient(
									colorTop: UIColor.init(hex: "56ab2f") ?? .systemBlue,
									colorBottom: UIColor.init(hex: "a8e063") ?? .systemGreen))))

		self.vrSkill.setContent(model: SkillView.SkillContent(
			skillModel: Skill(logo: UIImage(named: "VR"),
							  title: "VR-разработка",
							  description: """
• выпускник Samsung ШКОЛА VR 360
• Победитель всероссийского конкурса проектов "VR 360"
• Выпустил приложение в Unity Asset Store (Samsung написал статью о нас на офф.сайте)
""",
							  since: "с 2017 года",
							  gradients:
								ColorGradient(
									colorTop: UIColor.init(hex: "4568dc") ?? .systemBlue,
									colorBottom: UIColor.init(hex: "b06ab3") ?? .systemGreen))))

		self.iosSkill.setContent(model: SkillView.SkillContent(
			skillModel: Skill(logo: UIImage(named: "IOS"),
							  title: "iOS-разработка",
							  description: """
• Выпускник ШИФТЛАБ 2020/21 (TeamCFT)
• Разработчик оф. приложения НГУ для iOS (В январе релиз в AppStore)
• Участник ЦФТ FocusStart 2021/22
""",
							  since: "с 2020 года",
							  gradients:
								ColorGradient(
									colorTop: UIColor.init(hex: "ff9966") ?? .systemBlue,
									colorBottom: UIColor.init(hex: "ff5e62") ?? .systemGreen))))

		self.otherSkills.setContent(model: SkillView.SkillContent(
			skillModel: Skill(logo: UIImage(systemName: "bolt.circle.fill"),
							  title: "Прочие навыки",
							  description: """
• 3 место в Kaspersky CYBERHEROES 2016
• Middle Project manager (работаю в IT-компании в Казани)
""",
							  since: "",
							  gradients:
								ColorGradient(
									colorTop: UIColor.init(hex: "aa076b") ?? .systemBlue,
									colorBottom: UIColor.init(hex: "61045f") ?? .systemGreen))))
	}

	private func addSubviews() {
		self.addSubview(self.scrollView)
		self.scrollView.addSubview(self.contentView)
		self.contentView.addSubview(self.androidSkill)
		self.contentView.addSubview(self.vrSkill)
		self.contentView.addSubview(self.iosSkill)
		self.contentView.addSubview(self.otherSkills)
	}

	private func setConstraints() {
		self.scrollView.snp.makeConstraints { (make) in
			make.edges.equalToSuperview()
		}

		self.contentView.snp.makeConstraints { (make) in
			make.top.equalTo(self.scrollView)
			make.left.right.equalTo(self.scrollView)
			make.bottom.equalTo(self.scrollView).offset(-40)

			make.width.equalTo(self.scrollView)
			make.height.equalTo(960)
		}

		self.androidSkill.snp.makeConstraints { make in
			make.left.right.equalTo(self.contentView).inset(Metrics.spaceBetweenComponents)
			make.top.equalTo(self.contentView).offset(Metrics.spaceBetweenComponents)
		}

		self.vrSkill.snp.makeConstraints { make in
			make.left.right.equalTo(self.contentView).inset(Metrics.spaceBetweenComponents)
			make.top.equalTo(self.androidSkill.snp.bottom).offset(Metrics.spaceBetweenComponents)
		}

		self.iosSkill.snp.makeConstraints { make in
			make.left.right.equalTo(self.contentView).inset(Metrics.spaceBetweenComponents)
			make.top.equalTo(self.vrSkill.snp.bottom).offset(Metrics.spaceBetweenComponents)
		}

		self.otherSkills.snp.makeConstraints { make in
			make.left.right.equalTo(self.contentView).inset(Metrics.spaceBetweenComponents)
			make.top.equalTo(self.iosSkill.snp.bottom).offset(Metrics.spaceBetweenComponents)
		}
	}
}
