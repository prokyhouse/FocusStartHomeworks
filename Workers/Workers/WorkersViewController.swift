//
//  WorkersViewController.swift
//  Workers
//
//  Created by Кирилл Прокофьев on 21.12.2021.
//

import Foundation
import UIKit

class WorkersViewController: UITableViewController {

	var companyId: UUID
	fileprivate var workersArray = [worker]()

	init(companyId: UUID) {
		self.companyId = companyId
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		updateData()
		self.view.backgroundColor = .systemBackground
		self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Worker")
		NotificationCenter.default.addObserver(self, selector: #selector(reloadList), name: NSNotification.Name(rawValue: "reloadWorkers"), object: nil)

		let addButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addWorker))
		self.navigationItem.rightBarButtonItem  = addButton
	}

	@objc func addWorker(notification: NSNotification) {
		let addWorkerVC = addWorkerViewController(companyId: companyId)
		addWorkerVC.modalPresentationStyle = .pageSheet
		addWorkerVC.modalTransitionStyle = .coverVertical
		show(addWorkerVC, sender: true)
	}

	@objc func reloadList(notification: NSNotification) {
		workersArray = CoreDataManager.fetchWorkers(withId: companyId)
		tableView.reloadData()
	}

	func updateData() {
		workersArray = CoreDataManager.fetchWorkers(withId: companyId)
	}

	// MARK: - Table view data source

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return workersArray.count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Worker", for: indexPath)
		let currentLastItem = workersArray[indexPath.row]
		cell.textLabel?.text = currentLastItem.name
		return cell
	}

	override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			CoreDataManager.deleteWorkerWithId(id: workersArray[indexPath.row].id)
			workersArray.remove(at: indexPath.row)
			tableView.deleteRows(at: [indexPath], with: .fade)
		}
	}
}
