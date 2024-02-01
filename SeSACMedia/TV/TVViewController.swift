//
//  TVViewController.swift
//  SeSACMedia
//
//  Created by ungQ on 1/30/24.
//

import UIKit
import SnapKit
import Kingfisher

enum TVListType: Int, CaseIterable {
	case main
	case trend
	case topRated
	case popular

	var title: String {
		switch self {
		case .main:
			return ""
		case .trend:
			return "이번 주 트렌드"
		case .topRated:
			return "이번 주 최고 평점"
		case .popular:
			return "이번 주 가장 인기 있는!"
		}
	}

	var url: String {
		switch self {
		case .main:
			return ""
		case .trend:
			return "https://api.themoviedb.org/3/trending/tv/week?language=ko-KR"
		case .topRated:
			return "https://api.themoviedb.org/3/tv/top_rated?language=ko-KR"
		case .popular:
			return "https://api.themoviedb.org/3/tv/popular?language=ko-KR"
		}
	}
}

class TVViewController: BaseViewController {

	let mainTableView = UITableView()

	var trendList: [TV] = []
	var topRatedList: [TV] = []
	var popularList: [TV] = []
	var tvID: Int = 0 {
		didSet {
			UserDefaults.standard.setValue(tvID, forKey: "ID")
		}
	}

    override func viewDidLoad() {
        super.viewDidLoad()

		view.backgroundColor = .blue
		
		configureHierarchy()
		configureLayout()
		configureView()

		let group = DispatchGroup()

		group.enter()
		TMDBAPIManager.shared.fetchTVList(url: TVListType.trend.url) {
			self.trendList = $0
			group.leave()
		}

		group.enter()
		TMDBAPIManager.shared.fetchTVList(url: TVListType.topRated.url) {
			self.topRatedList = $0
			group.leave()
		}

		group.enter()
		TMDBAPIManager.shared.fetchTVList(url: TVListType.popular.url) {
			self.popularList = $0
			group.leave()
		}

		group.notify(queue: .main) {
			self.mainTableView.reloadData()
		}
    }

	override func configureHierarchy() {
		view.addSubview(mainTableView)
	}

	override func configureLayout() {
		mainTableView.snp.makeConstraints { make in
			make.edges.equalTo(view.safeAreaLayoutGuide)
		}
	}

	override func configureView() {
		mainTableView.delegate = self
		mainTableView.dataSource = self
		mainTableView.register(TVTableViewCell.self, forCellReuseIdentifier: "TVTableViewCell")
		mainTableView.register(TVSubTableViewCell.self, forCellReuseIdentifier: "TVSubTableViewCell")
		mainTableView.rowHeight = UITableView.automaticDimension

	}
}

//테이블뷰
extension TVViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

		return TVListType.allCases.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if indexPath.row == 0 {
			let cell = tableView.dequeueReusableCell(withIdentifier: "TVTableViewCell", for: indexPath) as! TVTableViewCell
			cell.selectionStyle = .none
			return configureFirstRowTableViewCell(cell: cell, list: trendList)

		} else {

			let cell = tableView.dequeueReusableCell(withIdentifier: "TVSubTableViewCell", for: indexPath) as! TVSubTableViewCell
			cell.selectionStyle = .none
			cell.collectionView.dataSource = self
			cell.collectionView.delegate = self
			cell.collectionView.register(TVSubCollectionViewCell.self, forCellWithReuseIdentifier: "TVSubCollectionViewCell")
			cell.collectionView.tag = indexPath.row

			cell.titleLabel.text = TVListType.allCases[indexPath.row].title

			cell.collectionView.reloadData()
			return cell

		}
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if indexPath.row == 0 {
			tvID = trendList.randomElement()?.id ?? 0
			print(tvID)
			print(UserDefaults.standard.integer(forKey: "ID"))
		}
	}

	func configureFirstRowTableViewCell(cell: TVTableViewCell, list: [TV]) -> TVTableViewCell {
		if let image = list.randomElement()?.poster {
			let url = URL(string: "https://image.tmdb.org/t/p/w500\(image)")
			cell.posterImageView.kf.setImage(with: url)
		} else {
			cell.posterImageView.image = UIImage(systemName: "xmark")
		}
		return cell
	}
}

//테이블뷰내 컬렉션뷰 (indexPath.row, collectionview.tag 1부터)
extension TVViewController: UICollectionViewDataSource, UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

		switch collectionView.tag {
		case 1: return trendList.count
		case 2: return topRatedList.count
		case 3: return popularList.count
		default: return 0
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TVSubCollectionViewCell", for: indexPath) as! TVSubCollectionViewCell

		switch collectionView.tag {
		case 1:
			return configureCollectionViewCell(cell: cell, list: trendList, item: indexPath.item)
		case 2:
			return configureCollectionViewCell(cell: cell, list: topRatedList, item: indexPath.item)
		case 3:
			return configureCollectionViewCell(cell: cell, list: popularList, item: indexPath.item)
		default:
			return cell
		}
	}

	func configureCollectionViewCell(cell: TVSubCollectionViewCell, list: [TV], item: Int) -> TVSubCollectionViewCell {

		if let image = list[item].poster {
			let url = URL(string: "https://image.tmdb.org/t/p/w500\(image)")
			cell.posterImageView.kf.setImage(with: url)
		} else {
			cell.posterImageView.image = UIImage(systemName: "xmark")
		}

		return cell
	}


	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		tvID = trendList[indexPath.item].id

		switch collectionView.tag {
		case 1:
			tvID = trendList[indexPath.item].id
		case 2:
			tvID = topRatedList[indexPath.item].id
		case 3:
			tvID = popularList[indexPath.item].id
		default:
			print("오류")
		}

		print(tvID)
		print(UserDefaults.standard.integer(forKey: "ID"))

		let vc = TVDetailViewController()
		navigationController?.pushViewController(vc, animated: true)

	}
}
