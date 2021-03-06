//
//  DetailView.swift
//  CollectionApp
//
//  Created by Кирилл Прокофьев on 17.11.2021.
//

import Foundation
import UIKit
import SnapKit

final class DetailView: UIView {
	private enum Metrics {
		static let spaceBetweenComponents: CGFloat = 9
		static let blurRadius: CGFloat = 16
		static let contentInset: CGFloat = 30
		static let cornerRadius: CGFloat = 12
		static let titleSize: CGFloat = 22
		static let numberOfLines = 4
	}
	
	private let posterView = UIImageView()
	private let titleLabel = UILabel()
	private let descriptionLabel = UILabel()
	internal let moreButton = UIButton()
	private let contentView = UIView()
	
	public override init(frame: CGRect) {
		super.init(frame: frame)
		//self.configure()
	}
	
	public required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func configure() {
		self.setConfig()
		self.addSubviews()
		self.setConstraints()
	}
	
	private func setConfig() {
		
		self.contentView.backgroundColor = .black
		self.contentView.layer.cornerRadius = Metrics.cornerRadius
		
		self.backgroundColor = .black
		
		self.posterView.contentMode = .scaleAspectFill
		
		self.titleLabel.textColor = .white
		self.titleLabel.textAlignment = .center
		self.titleLabel.font = UIFont.systemFont(ofSize: Metrics.titleSize, weight: UIFont.Weight.bold)
		
		self.descriptionLabel.numberOfLines = Metrics.numberOfLines
		self.descriptionLabel.textColor = .white
		
		self.moreButton.setTitle("полное описание", for: .normal)
		self.moreButton.setTitleColor(UIColor(named: "AccentColor"), for: .normal)
		self.moreButton.setTitleColor(.white, for: .highlighted)
		self.moreButton.titleLabel?.adjustsFontSizeToFitWidth = true
	}
	
	func setContent(model: Movie) {
		self.posterView.image = UIImage(named: model.title)?.blurred(radius: Metrics.blurRadius)
		self.posterView.clipsToBounds = true
		self.titleLabel.text = model.title
		self.descriptionLabel.text = model.overview
	}
	
	private func addSubviews() {
		self.addSubview(self.posterView)
		self.addSubview(self.contentView)
		self.contentView.addSubview(self.descriptionLabel)
		self.contentView.addSubview(self.moreButton)
	}
	
	private func setConstraints() {
		self.posterView.snp.makeConstraints { make in
			make.left.right.top.bottom.equalToSuperview()
		}
		
		self.contentView.snp.makeConstraints { make in
			make.centerY.centerX.equalToSuperview()
			make.right.left.equalToSuperview().inset(Metrics.contentInset)
			make.bottom.equalTo(self.moreButton).offset(Metrics.spaceBetweenComponents)
		}
		
		self.descriptionLabel.snp.makeConstraints { make in
			make.top.left.right.equalTo(self.contentView).inset(Metrics.spaceBetweenComponents)
		}
		
		self.moreButton.snp.makeConstraints { make in
			make.centerX.equalTo(self.contentView)
			make.top.equalTo(self.descriptionLabel.snp.bottom).offset(Metrics.spaceBetweenComponents)
			make.height.equalTo(Metrics.spaceBetweenComponents).multipliedBy(2)
		}
	}
}
