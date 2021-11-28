//
//  DetailViewController.swift
//  CollectionApp
//
//  Created by Кирилл Прокофьев on 17.11.2021.
//

import Foundation
import UIKit

final class DetailViewController: UIViewController {
	private var detailView: DetailView
	private var detailViewPresenter: DetailViewPresenter
	var model = MovieModel()

	init() {
		self.detailView = DetailView(frame: UIScreen.main.bounds)
		self.detailViewPresenter = DetailViewPresenter()
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func loadView() {
		detailView.setContent(model: model.getMovie())
		super.loadView()
		self.detailViewPresenter.loadView(controller: self, view: self.detailView)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.title = model.getTitle()
		self.detailView.moreButton.addTarget(self, action: #selector(openOverview), for: .touchUpInside)
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		self.tabBarController?.tabBar.isHidden = true
		self.view.addSubview(detailView)
	}
	
	@IBAction func openOverview(_ sender: Any) {

		let overviewVC = OverviewViewController()
		overviewVC.viewModel.updateModel(movie: model.getMovie())
		overviewVC.modalPresentationStyle = .pageSheet
		overviewVC.modalTransitionStyle = .coverVertical
		//overviewVC.movie = model.getMovie()
		present(overviewVC, animated: true)
	}
	
	private func configure() {
		self.title = "Details"
		self.view.backgroundColor = .systemBackground
		
		let label = UILabel()
		label.text = "SOME DETAILS"
		
		self.view.addSubview(label)
		label.pinToSuperviewCenter()
	}
}
