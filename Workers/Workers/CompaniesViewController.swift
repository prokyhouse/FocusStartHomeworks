//
//  CompaniesViewController.swift
//  Workers
//
//  Created by Кирилл Прокофьев on 18.12.2021.
//

import UIKit

class CompaniesViewController: UITableViewController, UISearchBarDelegate {

	fileprivate var companiesArray = [company]()

	override func viewDidLoad() {
		super.viewDidLoad()
		self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Company")
		NotificationCenter.default.addObserver(self, selector: #selector(reloadList), name: NSNotification.Name(rawValue: "reload"), object: nil)
		updateData()
		setUpSearchBar()
	}

	@objc func reloadList(notification: NSNotification) {
		companiesArray = CoreDataManager.fetchObj()
		tableView.reloadData()
	}

	// MARK: - search bar related
	fileprivate func setUpSearchBar() {
		let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 65))

		searchBar.delegate = self
		searchBar.showsBookmarkButton = true
		searchBar.setImage(UIImage(systemName: "plus"), for: .bookmark, state: .normal)

		self.tableView.tableHeaderView = searchBar
	}

	func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
		let addCompanyVC = addCompanyViewController()
		addCompanyVC.modalPresentationStyle = .pageSheet
		addCompanyVC.modalTransitionStyle = .coverVertical
		show(addCompanyVC, sender: true)
	}

	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

		guard !searchText.isEmpty else {
			companiesArray = CoreDataManager.fetchObj()
			tableView.reloadData()
			return
		}
		companiesArray = CoreDataManager.fetchObj(selectedScopeIdx: searchBar.selectedScopeButtonIndex, targetText: searchText)
		tableView.reloadData()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}

	func updateData() {
		companiesArray = CoreDataManager.fetchObj()
	}

	// MARK: - Table view data source

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return companiesArray.count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Company", for: indexPath)
		let currentLastItem = companiesArray[indexPath.row]
		cell.textLabel?.text = currentLastItem.companyName
		return cell
	}

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let companyId = companiesArray[indexPath.row].companyId
		let workersVC = WorkersViewController(companyId: companyId)
		workersVC.companyId = companyId
		self.navigationController?.pushViewController(workersVC, animated: true)
	}

	override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			CoreDataManager.deleteCompanyWithId(id: companiesArray[indexPath.row].companyId)
			companiesArray.remove(at: indexPath.row)
			tableView.deleteRows(at: [indexPath], with: .fade)
		}
	}
}
