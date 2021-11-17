//
//  FilmsListViewController.swift
//  CollectionApp
//
//  Created by Кирилл Прокофьев on 17.11.2021.
//

import Foundation

import UIKit
import Combine
import SnapKit

final class FilmsListViewController: UIViewController {


	private lazy var collectionView: UICollectionView = {
		let flowLayout = FlowLayout()
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
		collectionView.backgroundColor = UIColor.systemBackground
		collectionView.alwaysBounceVertical = true
		collectionView.register(FilmCell.self, forCellWithReuseIdentifier: FilmCell.identifier)
		collectionView.delegate = self
		collectionView.dataSource = self
		return collectionView
	}()

	private let movies = Movie.sampleData

	override func loadView() {
		self.view = self.collectionView
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		let title = "Фильмы"
		self.title = title
		overrideUserInterfaceStyle = .dark
		navigationController?.navigationBar.prefersLargeTitles = true
	}
}

extension FilmsListViewController: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let detailVC = DetailViewController()
		detailVC.movie = self.movies[indexPath.item]
		self.navigationController?.pushViewController(detailVC, animated: true)
	}

	func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
		indexPath.row == 0 ? false : true
	}
}

extension FilmsListViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		self.movies.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilmCell.identifier, for: indexPath) as! FilmCell
		cell.movie = self.movies[indexPath.item]
		return cell
	}
}
