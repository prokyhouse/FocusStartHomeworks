//
//  HobbyView.swift
//  myCV
//
//  Created by Кирилл Прокофьев on 13.11.2021.
//

import Foundation
import UIKit
import SnapKit

protocol IHobbyView: AnyObject {
	var onShare: (() -> Void)? { get set }
}

class HobbyView: UIView {
	var onShare: (() -> Void)?

	struct HobbyContent {
		internal let title: String
		internal let description: String
		internal let photoName: String
		internal let link: String

		internal init() {
			self.title = "Моё хобби".uppercased()
			self.description = """
Помимо IT, я профессионально занимаюсь фотографией с 2017 года.
Больше моих работ вы сможете найти в моём Instagram-аккаунте.
"""
			self.photoName = "MyPhoto"
			self.link = "instagram.com/prokofev.k"
		}
	}

//	private func setHooks() {
//		self.subscribeView.onShare = { [weak self] in
//			self?.onShareButton?()
//		}
//	}


	private let photoView = UIImageView()
	internal let instagramButton = UIButton()
	private let titleLabel = UILabel()
	private let descriptionLabel = UILabel()
	private let contentView = UIView()
	private var linkForShare: String = "instagram.com"

	public override init(frame: CGRect) {
		super.init(frame: frame)
		self.configure()
	}

	public required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func layoutSubviews() {
		super.layoutSubviews()
		self.contentView.setGradientBackground(colorTop: .black ,
											   colorBottom: UIColor.clear,
											   startY: 0.4,
											   endY: 0)
	}

	private func configure() {
		self.setConfig()
		self.setContent(model: HobbyContent.init())
		self.addSubviews()
		self.setConstraints()
	}

	private func setConfig() {
		self.instagramButton.backgroundColor = .white
		self.instagramButton.setImage(UIImage(systemName: "livephoto.play"), for: .normal)
		self.instagramButton.setTitle("профиль Instagram", for: .normal)
		self.instagramButton.setTitleColor(UIColor(named: "AccentColor"), for: .normal)
		self.instagramButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
		self.instagramButton.setTitleColor(.black, for: .highlighted)
		self.instagramButton.titleLabel?.adjustsFontSizeToFitWidth = true
		self.instagramButton.layer.cornerRadius = 10
		//self.instagramButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)

		self.titleLabel.textColor = .white

		self.photoView.contentMode = .scaleAspectFill

		self.titleLabel.font = UIFont.Title.large
		self.titleLabel.textAlignment = .center
		self.titleLabel.adjustsFontSizeToFitWidth = true

		self.backgroundColor = .red

		self.descriptionLabel.textColor = .white
		self.descriptionLabel.numberOfLines = 8
		self.descriptionLabel.adjustsFontSizeToFitWidth = true
	}



	internal func setContent(model: HobbyContent) {
		self.photoView.image = UIImage(named: model.photoName)
		self.titleLabel.text = model.title
		self.descriptionLabel.text = model.description
		self.linkForShare = model.link
	}

	private func addSubviews() {
		self.addSubview(self.photoView)
		self.addSubview(self.contentView)
		self.contentView.addSubview(self.titleLabel)
		self.contentView.addSubview(self.descriptionLabel)
		self.contentView.addSubview(self.instagramButton)
	}

	private func setConstraints() {
		self.photoView.snp.makeConstraints { make in
			make.centerX.equalTo(self.snp.centerX)
			make.left.right.top.equalToSuperview()
			make.bottom.equalToSuperview().offset(-260)
			make.height.lessThanOrEqualTo(650)
		}

		self.contentView.snp.makeConstraints { make in
			make.left.right.equalToSuperview()
			make.bottom.equalTo(self.snp.bottom)
			make.top.equalTo(self.photoView.snp.bottom).offset(-170)
		}

		self.titleLabel.snp.makeConstraints { make in
			make.left.right.equalToSuperview().inset(20)
			make.top.equalTo(self.contentView.snp.top).offset(84)
			make.height.equalTo(30)
		}

		self.instagramButton.snp.makeConstraints { make in
			//make.left.right.equalTo(self.contentView).inset(67)
			make.top.equalTo(self.titleLabel.snp.bottom).offset(20)
			make.centerX.equalTo(self.contentView.snp.centerX)
			make.width.equalTo(240)
			make.height.equalTo(42)
		}

		self.descriptionLabel.snp.makeConstraints { make in
			make.left.right.equalTo(self.contentView).inset(19)
			make.top.equalTo(self.instagramButton.snp.bottom).offset(20)
			//make.bottom.equalTo(self.contentView.snp.bottom).offset(-60)
			//make.height.equalTo(100)
		}
	}
}
