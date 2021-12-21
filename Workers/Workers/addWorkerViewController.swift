//
//  addWorkerViewController.swift
//  Workers
//
//  Created by Кирилл Прокофьев on 21.12.2021.
//

import Foundation
import UIKit
import SnapKit

class addWorkerViewController: UIViewController {

	var companyId: UUID

	init(companyId: UUID) {
		self.companyId = companyId
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	var experienceSlider = UISlider()
	private var saveButton = UIButton()
	let nameLabel = UILabel()
	private var nameTextField = UITextField()
	let experienceLabel = UILabel()
	private var experienceTextField = UITextField()

	var roundedStepValue: Int64 = 0

	private let dateLabel = UILabel()
	let datePicker = UIDatePicker()

	private enum Metrics {
		static let spaceBetweenComponents: CGFloat = 14
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		let title = "Новый"
		self.title = title
		self.configure()
		self.addConstraints()
	}

	private func configure() {

		experienceSlider = UISlider(frame: CGRect(x: 0, y: 0, width: 300, height: 20))
		experienceSlider.center = self.view.center

		// Posiiton date picket within a view
		datePicker.frame = CGRect(x: 10, y: 50, width: self.view.frame.width, height: 200)

		// Set some of UIDatePicker properties
		datePicker.timeZone = NSTimeZone.local
		datePicker.backgroundColor = UIColor.white

		datePicker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)

		experienceSlider.addTarget(self, action: #selector(self.sliderValueDidChange(_:)), for: .valueChanged)

		self.view.backgroundColor = .systemBackground

		let add = UIAction(handler: { [weak self] _ in

			let newWorker = worker(name: self?.nameTextField.text ?? "Нет имени",
								   companyId: self?.companyId ?? UUID(),
								   experience: self?.roundedStepValue ?? 0,
								   birthday: self?.datePicker.date ?? Date())

			CoreDataManager.addWorker(name: newWorker.name, companyId: newWorker.companyId, experience: newWorker.experience, birthday: newWorker.birthday)
			NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadWorkers"), object: nil)
		})

		saveButton = UIButton(type: .system, primaryAction: add)

		nameLabel.text = "Введите имя:"

		nameTextField.backgroundColor = UIColor.lightText

		saveButton.setTitle("Сохранить", for: .normal)
		saveButton.setTitleColor(UIColor.systemBlue, for: .normal)

		experienceLabel.text = "Введите стаж: (\(Int(roundedStepValue))) лет"

		dateLabel.text = "Дата рождения:"

		experienceSlider.minimumValue = 0
		experienceSlider.maximumValue = 50
		experienceSlider.isContinuous = true
		experienceSlider.tintColor = UIColor.green

		self.view.addSubview(saveButton)
		self.view.addSubview(nameLabel)
		self.view.addSubview(nameTextField)
		self.view.addSubview(experienceLabel)
		self.view.addSubview(dateLabel)
		self.view.addSubview(datePicker)
		self.view.addSubview(experienceSlider)
	}

	@objc func sliderValueDidChange(_ sender: UISlider!) {
		let roundedStepValue = round(sender.value)
		sender.value = roundedStepValue
	}

	private func addConstraints() {
		nameLabel.snp.makeConstraints { make in
			make.left.right.equalToSuperview().inset(Metrics.spaceBetweenComponents)
			make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
			make.height.equalTo(20)
		}

		nameTextField.snp.makeConstraints { make in
			make.left.right.equalToSuperview().inset(Metrics.spaceBetweenComponents)
			make.top.equalTo(self.nameLabel.snp.bottom).offset(9)
			make.height.equalTo(20)
		}

		dateLabel.snp.makeConstraints { make in
			make.left.right.equalToSuperview().inset(Metrics.spaceBetweenComponents)
			make.top.equalTo(self.nameTextField.snp.bottom).offset(20)
			make.height.equalTo(20)
		}

		datePicker.snp.makeConstraints { make in
			make.left.equalToSuperview().inset(Metrics.spaceBetweenComponents)
			make.top.equalTo(self.dateLabel.snp.bottom).offset(9)
		}

		experienceLabel.snp.makeConstraints { make in
			make.left.right.equalToSuperview().inset(Metrics.spaceBetweenComponents)
			make.top.equalTo(self.datePicker.snp.bottom).offset(20)
			make.height.equalTo(20)
		}

		experienceSlider.snp.makeConstraints { make in
			make.left.right.equalToSuperview().inset(Metrics.spaceBetweenComponents)
			make.top.equalTo(self.experienceLabel.snp.bottom).offset(9)
			make.height.equalTo(20)
		}

		saveButton.snp.makeConstraints { make in
			make.right.left.equalToSuperview().inset(Metrics.spaceBetweenComponents)
			make.top.equalTo(self.experienceSlider.snp.bottom).offset(9)
			make.height.equalTo(20)

		}
	}

	@objc func datePickerValueChanged(_ sender: UIDatePicker) {
		let dateFormatter: DateFormatter = DateFormatter()
		dateFormatter.dateFormat = "MM/dd/yyyy hh:mm a"
		let selectedDate: String = dateFormatter.string(from: sender.date)
	}
}
