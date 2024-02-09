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

	var tvID: Int = 0 {
		didSet {
			UserDefaults.standard.setValue(tvID, forKey: "ID")
		}
	}

	var tvTitle: String = "" {
		didSet {
			UserDefaults.standard.setValue(tvTitle, forKey: "Title")
		}
	}

	override func loadView() {
		view = mainView
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		navigationItem.title = "검색"
		let backBarButton = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
		navigationItem.backBarButtonItem = backBarButton


		mainView.searchBar.delegate = self

		mainView.searchCollectionView.delegate = self
		mainView.searchCollectionView.dataSource = self
		mainView.searchCollectionView.register(TVSubCollectionViewCell.self, forCellWithReuseIdentifier: TVSubCollectionViewCell.identifier)

	}

	@objc func didTapView(_ sender: UITapGestureRecognizer) {
		view.endEditing(true)
	}
}


extension SearchViewController: UISearchBarDelegate {



	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		TMDBSessionManager.shared.fetchSearchingMovie(query: searchBar.text ?? "") { list, error in
			if error == nil {
				guard let list = list else { return }
				self.list = list.results ?? []

				self.mainView.searchCollectionView.reloadData()
				
				self.view.endEditing(true)
			}
		}
	}
}


extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return list.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TVSubCollectionViewCell.identifier, for: indexPath) as! TVSubCollectionViewCell

		if let image = list[indexPath.row].posterPath {
			let url = URL(string: "https://image.tmdb.org/t/p/w500\(image)")
			cell.posterImageView.kf.setImage(with: url)
		}

		return cell
	}

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		
		tvID = list[indexPath.row].id
		tvTitle = list[indexPath.row].name

		let vc = TVDetailViewController()
		navigationController?.pushViewController(vc, animated: true)
	}


}
//
//
//extension SearchViewController: UICollectionViewDataSourcePrefetching {
////	
////	func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
////		<#code#>
////	}
//	
//
//}
