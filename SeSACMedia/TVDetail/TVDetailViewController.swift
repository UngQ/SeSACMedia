//
//  TVDetailViewController.swift
//  SeSACMedia
//
//  Created by ungQ on 1/31/24.
//

import UIKit
import SnapKit
import Alamofire
import Kingfisher


class TVDetailViewController: BaseViewController {

	static var selectedTV: DetailTVModel = DetailTVModel(id: 0, name: "", overview: "", seasons: nil, poster: "", firstAirDate: "", lastAirDate: "", voteAverage: 0)
	static var castList: [Cast] = []
	static var recommendList: [TV] = []

	let mainView = TVDetailView()

	override func loadView() {
		view = mainView
	}

	override func viewDidLoad() {
		super.viewDidLoad()
	}

	override func configureView() {
		configureNavigationBar()
		
		mainView.mainTableView.delegate = self
		mainView.mainTableView.dataSource = self
		mainView.mainTableView.register(TVSubTableViewCell.self, forCellReuseIdentifier: "TableViewCellInDetail")
		mainView.mainTableView.rowHeight = UITableView.automaticDimension
	}

	func configureNavigationBar() {
		navigationItem.title = UserDefaults.standard.string(forKey: "Title")
		navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
	}
}


extension TVDetailViewController: UITableViewDelegate, UITableViewDataSource {

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		2
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = mainView.mainTableView.dequeueReusableCell(withIdentifier: "TableViewCellInDetail", for: indexPath) as! TVSubTableViewCell

		cell.collectionView.tag = indexPath.row
		cell.collectionView.dataSource = self
		cell.collectionView.delegate = self
		cell.collectionView.register(TVSubCollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCellInDetail")

		cell.collectionView.reloadData()
		if indexPath.row == 0 {
			cell.titleLabel.text = "출연진"
			return cell
		} else {
			cell.titleLabel.text = "비슷한 콘텐츠"
			(cell.collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.scrollDirection = .vertical
			return cell
		}
	}

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		if indexPath.row == 0 {
			return 168
		} else {
			return 312
		}
	}
}

extension TVDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		if collectionView.tag == 0 {
			return TVDetailViewController.castList.count
		} else {
			return TVDetailViewController.recommendList.count
		}
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCellInDetail", for: indexPath) as! TVSubCollectionViewCell

		if collectionView.tag == 0 {
			if let image = TVDetailViewController.castList[indexPath.item].profilePath {
				let url = URL(string: "https://image.tmdb.org/t/p/w500\(image)")
				cell.posterImageView.kf.setImage(with: url)
			} else {
				cell.posterImageView.image = UIImage(systemName: "xmark")
			}
		} else {
			if let image = TVDetailViewController.recommendList[indexPath.item].posterPath {
				let url = URL(string: "https://image.tmdb.org/t/p/w500\(image)")
				cell.posterImageView.kf.setImage(with: url)
			} else {
				cell.posterImageView.image = UIImage(systemName: "xmark")
			}
		}
		return cell
	}
}
