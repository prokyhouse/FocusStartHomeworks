//
//  FilmsListViewController.swift
//  CollectionApp
//
//  Created by Кирилл Прокофьев on 17.11.2021.
//

import Foundation
import UIKit
import SnapKit

final class MovieListViewController: UIViewController {

	private lazy var collectionView: UICollectionView = {
		let flowLayout = FlowLayout()
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
		collectionView.backgroundColor = UIColor.systemBackground
		collectionView.alwaysBounceVertical = true
		collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.identifier)
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
		navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor(named: "AccentColor") ?? .red]
		navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
		navigationController?.navigationBar.prefersLargeTitles = true
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		self.tabBarController?.tabBar.isHidden = false
	}
}

extension MovieListViewController: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let detailVC = DetailViewController.init()
		let movie = self.movies[indexPath.item]
		detailVC.model.setMovie(movie: movie)
		self.navigationController?.pushViewController(detailVC, animated: true)
	}

	func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
		return true
	}
}

extension MovieListViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		self.movies.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.identifier, for: indexPath) as! MovieCell
		cell.movie = self.movies[indexPath.item]
		return cell
	}
}
