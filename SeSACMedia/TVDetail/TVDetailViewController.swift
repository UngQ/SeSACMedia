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

enum DetailInfoType: Int, CaseIterable {
	case cast
	case recommend

	var title: String {
		switch self {
		case .cast:
			return "출연진 바보"
		case .recommend:
			return "비슷한 콘텐츠"
		}
	}

	var castList: [Cast] {
		return TVDetailViewController.castList
	}

	var recommendList: [TV] {
		return TVDetailViewController.recommendList
	}

	var count: Int {
		switch self {
		case .cast:
			return TVDetailViewController.castList.count
		case .recommend:
			return TVDetailViewController.recommendList.count
		}
	}

	var layout: UICollectionViewLayout {
		switch self {
		case .cast:
			return TVSubTableViewCell.configureCollectionViewLayout(size: CGSize(width: UIScreen.main.bounds.width / 3 - 8  , height: (UIScreen.main.bounds.width / 3 - 8)), direction: .horizontal)
		case .recommend:
			return TVSubTableViewCell.configureCollectionViewLayout(size: CGSize(width: UIScreen.main.bounds.width / 3 - 8  , height: (UIScreen.main.bounds.width / 3 - 8) * 1.4), direction: .vertical)
		}
	}

	var height: CGFloat {
		switch self {
		case .cast:
			return (UIScreen.main.bounds.width / 3 - 8) * 1.4
		case .recommend:
			let firstRowHeight = (UIScreen.main.bounds.width / 3 - 8) * 1.4
			let tableViewHeight = TVDetailView.mainTableView.bounds.height
			let height = tableViewHeight - firstRowHeight

			return height
		}
	}
}

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
		
		TVDetailView.mainTableView.delegate = self
		TVDetailView.mainTableView.dataSource = self
		TVDetailView.mainTableView.register(TVSubTableViewCell.self, forCellReuseIdentifier: "TableViewCellInDetail")

	}

	func configureNavigationBar() {
		navigationItem.title = UserDefaults.standard.string(forKey: "Title")
		navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
	}
}


extension TVDetailViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return DetailInfoType.allCases.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = TVDetailView.mainTableView.dequeueReusableCell(withIdentifier: "TableViewCellInDetail", for: indexPath) as! TVSubTableViewCell

		cell.collectionView.tag = indexPath.row
		cell.collectionView.dataSource = self
		cell.collectionView.delegate = self
		cell.collectionView.register(TVSubCollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCellInDetail")
		cell.selectionStyle = .none

		if let listType = DetailInfoType(rawValue: cell.collectionView.tag) {
			cell.titleLabel.text = listType.title
			cell.collectionView.collectionViewLayout = listType.layout
		}

		cell.collectionView.reloadData()
		return cell
	}

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

		guard let listType = DetailInfoType(rawValue: indexPath.row) else { return 0 }
		return listType.height
	}
}

extension TVDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		
		guard let listType = DetailInfoType(rawValue: collectionView.tag) else { return 0 }
		return listType.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCellInDetail", for: indexPath) as! TVSubCollectionViewCell

		cell.posterImageView.image = UIImage(systemName: "xmark")
		cell.posterImageView.contentMode = .scaleAspectFit

		if collectionView.tag == DetailInfoType.cast.rawValue {
			guard let image = TVDetailViewController.castList[indexPath.row].profilePath else { return cell }
			let url = URL(string: "https://image.tmdb.org/t/p/w500\(image)")
			cell.posterImageView.kf.setImage(with: url)
			cell.posterImageView.contentMode = .scaleAspectFill
		} else if collectionView.tag == DetailInfoType.recommend.rawValue {
			guard let image = TVDetailViewController.recommendList[indexPath.row].posterPath else { return cell }
			let url = URL(string: "https://image.tmdb.org/t/p/w500\(image)")
			cell.posterImageView.kf.setImage(with: url)
			cell.posterImageView.contentMode = .scaleAspectFill
		}

		return cell
	}
}
