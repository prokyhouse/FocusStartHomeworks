//
//  ViewModel.swift
//  CollectionApp
//
//  Created by Кирилл Прокофьев on 28.11.2021.
//

import Foundation

class Observable<T> {
	var overview: T {
		didSet {
			self.notify?(self.overview)
		}
	}

	private var notify: ((T) -> Void)?

	init(_ overview: T) {
		self.overview = overview
	}

	func setNotify(notify: @escaping ((T) -> Void)) {
		self.notify = notify
		self.notify?(self.overview)
	}
}

class ViewModel {
	private let model = MovieModel()
	var updateDataHandler: ((String) -> Void)?

	var data: Observable<String> = Observable<String>("Loading...")

	func updateModel(movie: Movie) {
		DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) { [weak self] in
			self?.model.setMovie(movie: movie)
			DispatchQueue.main.async { [weak self] in
				let viewData = self?.model.getOverview()
				self?.data.overview = viewData ?? ""
			}
		}
	}
}
