//
//  DetailViewPresenter.swift
//  CollectionApp
//
//  Created by Кирилл Прокофьев on 28.11.2021.
//

import Foundation

class DetailViewPresenter {
	private let model = MovieModel()
	private weak var controller: DetailViewController?
	private weak var view: DetailView?

	func loadView(controller: DetailViewController, view: DetailView) {
		self.controller = controller
		self.view = view
		self.view?.configure()
	}
}
