//
//  SearchViewController.swift
//  SeSACMedia
//
//  Created by ungQ on 2/3/24.
//

import UIKit
import SnapKit

class SearchViewController: BaseViewController {

	let mainView = SearchView()

	var list: [TV] = []

	override func loadView() {
		view = mainView
	}

    override func viewDidLoad() {
        super.viewDidLoad()

		navigationItem.title = "검색"

		mainView.searchBar.delegate = self

		mainView.searchCollectionView.delegate = self
		mainView.searchCollectionView.dataSource = self
		mainView.searchCollectionView.register(TVSubCollectionViewCell.self, forCellWithReuseIdentifier: "Search")

    }



}

extension SearchViewController: UISearchBarDelegate {

	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		TMDBSessionManager.shared.fetchSearchingMovie(query: searchBar.text ?? "") { list, error in
			if error == nil {
				guard let list = list else { return }
				self.list = list.results ?? []

				self.mainView.searchCollectionView.reloadData()

			}
		}
	}
}


extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return list.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Search", for: indexPath) as! TVSubCollectionViewCell

		if let image = list[indexPath.row].posterPath {
			let url = URL(string: "https://image.tmdb.org/t/p/w500\(image)")
			cell.posterImageView.kf.setImage(with: url)
		}

		return cell
	}
	

}
