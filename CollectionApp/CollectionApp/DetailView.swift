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

	private var contentModel: Movie = Movie(title: "smth", overview: "overview", genres: ["genre"])

	private enum Metrics {
	}


	private let posterView = UIImageView()
	private let titleLabel = UILabel()
	private let descriptionLabel = UILabel()
	private let contentView = UIView()

	public override init(frame: CGRect) {
		super.init(frame: frame)
		self.configure()
	}

	public required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	

	private func configure() {
		self.setConfig()
		//self.setContent(model: DetailContent.init())
		self.addSubviews()
		self.setConstraints()
	}

	private func setConfig() {
		

		self.contentView.backgroundColor = .black
		self.contentView.layer.cornerRadius = 12

		self.backgroundColor = .black

		self.titleLabel.textColor = .white

		self.posterView.contentMode = .scaleAspectFill

		self.titleLabel.textAlignment = .center
		self.descriptionLabel.numberOfLines = 10
		self.titleLabel.font = UIFont.systemFont(ofSize: 22, weight: UIFont.Weight.bold)


		self.descriptionLabel.textColor = .white
		self.descriptionLabel.numberOfLines = 8

	}

	func setContent(model: Movie) {
		self.contentModel = model
		self.posterView.image = UIImage(named: model.title)?.blurred(radius: 16.0)
		self.titleLabel.text = model.title
		self.descriptionLabel.text = model.overview
	}

	private func addSubviews() {
		self.addSubview(self.posterView)
		self.addSubview(self.contentView)
		self.contentView.addSubview(self.descriptionLabel)
	}

	private func setConstraints() {
		self.posterView.snp.makeConstraints { make in
			make.left.right.top.bottom.equalToSuperview()
		}

		self.contentView.snp.makeConstraints { make in
			make.centerY.centerX.equalToSuperview()
			make.right.left.equalToSuperview().inset(30)
		}

		self.descriptionLabel.snp.makeConstraints { make in
			make.top.bottom.left.right.equalTo(self.contentView).inset(9)
		}
	}
}

extension UIImage {
	func blurred(radius: CGFloat) -> UIImage {
		let ciContext = CIContext(options: nil)
		guard let cgImage = cgImage else { return self }
		let inputImage = CIImage(cgImage: cgImage)
		guard let ciFilter = CIFilter(name: "CIGaussianBlur") else { return self }
		ciFilter.setValue(inputImage, forKey: kCIInputImageKey)
		ciFilter.setValue(radius, forKey: "inputRadius")
		guard let resultImage = ciFilter.value(forKey: kCIOutputImageKey) as? CIImage else { return self }
		guard let cgImage2 = ciContext.createCGImage(resultImage, from: inputImage.extent) else { return self }
		return UIImage(cgImage: cgImage2)
	}
}

