//
//  addWorkerViewController.swift
//  Workers
//
//  Created by Кирилл Прокофьев on 20.12.2021.
//

import Foundation
import UIKit
import SnapKit

class addCompanyViewController: UIViewController {

	let label = UILabel()
	private var closeButton = UIButton()
	private var saveButton = UIButton()
	private var companyTextField = UITextField()

	private enum Metrics {
		static let spaceBetweenComponents: CGFloat = 9
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		self.configure()
		self.addConstraints()
	}

	private func configure() {
		self.view.backgroundColor = .systemBackground

		let action = UIAction(handler: { [weak self] _ in
			self?.dismiss(animated: true)
		})

		let add = UIAction(handler: { [weak self] _ in
			guard let companyName = self?.companyTextField.text else {
				self?.dismiss(animated: true)
				return  }
			CoreDataManager.addCompany(name: companyName)
			NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reload"), object: nil)
		})

		closeButton = UIButton(type: .system, primaryAction: action)
		closeButton.setImage(.init(systemName: "xmark"), for: .normal)
		closeButton.tintColor = .label

		saveButton = UIButton(type: .system, primaryAction: add)

		label.numberOfLines = 40
		label.textAlignment = .center
		label.text = "Введите название компании"

		companyTextField.backgroundColor = UIColor.lightGray
		companyTextField.layer.cornerRadius = 16

		saveButton.setTitle("Сохранить", for: .normal)
		saveButton.setTitleColor(UIColor.systemBlue, for: .normal)

		self.view.addSubview(closeButton)
		self.view.addSubview(saveButton)
		self.view.addSubview(label)
		self.view.addSubview(companyTextField)
	}

	private func addConstraints() {
		label.snp.makeConstraints { make in
			make.left.right.equalToSuperview().inset(Metrics.spaceBetweenComponents)
			make.bottom.equalTo(companyTextField.snp.top)
		}
		companyTextField.snp.makeConstraints { make in
			make.left.equalToSuperview().offset(16)
			make.right.equalToSuperview().offset(-16)
			make.top.equalTo(self.label.snp.bottom)
			make.centerX.centerY.equalToSuperview()
		}
		saveButton.snp.makeConstraints { make in
			make.top.right.equalToSuperview().inset(Metrics.spaceBetweenComponents)

		}
		closeButton.snp.makeConstraints { make in
			make.left.top.equalToSuperview().inset(Metrics.spaceBetweenComponents)
		}
	}
}
