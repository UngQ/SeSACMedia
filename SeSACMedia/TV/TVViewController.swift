//
//  TVViewController.swift
//  SeSACMedia
//
//  Created by ungQ on 1/30/24.
//

import UIKit
import SnapKit
import Kingfisher

enum TVListType: String, CaseIterable {
	case main
	case trend = "이번 주 트렌드"
	case topRated = "이번 주 최고 평점"
	case popular = "이번 주 가장 인기 있는!"

	var url: String {
		switch self {
		case .main:
			return ""
		case .trend:
			return "https://api.themoviedb.org/3/trending/tv/week?language=ko-KR"
		case .topRated:
			return "https://api.themoviedb.org/3/tv/top_rated?language=ko-KR"
		case .popular:
			return "https://api.themoviedb.org/3/tv/top_rated?language=ko-KR"
		}
	}
}

class TVViewController: UIViewController {

	let tableView = UITableView()

	var trendTVList: [TV] = []
	var topRatedTVList: [TV] = []
	var popularTVList: [TV] = []

    override func viewDidLoad() {
        super.viewDidLoad()

		view.backgroundColor = .blue
		
		configureHierarchy()
		configureLayout()
		configureView()

		TMDBAPIManager.shared.fetchTVList(url: TVListType.trend.url) { TV in
			self.trendTVList = TV
			self.tableView.reloadData()
		}

		TMDBAPIManager.shared.fetchTVList(url: TVListType.topRated.url) { TV in
			self.topRatedTVList = TV
			self.tableView.reloadData()
			print(self.trendTVList)
		}

		TMDBAPIManager.shared.fetchTVList(url: TVListType.popular.url) { TV in
			self.popularTVList = TV
			self.tableView.reloadData()
			print(self.popularTVList)
		}
    }

	func configureHierarchy() {
		view.addSubview(tableView)
	}

	func configureLayout() {
		tableView.snp.makeConstraints { make in
			make.edges.equalTo(view.safeAreaLayoutGuide)
		}
	}

	func configureView() {
		tableView.delegate = self
		tableView.dataSource = self
		tableView.register(TVTableViewCell.self, forCellReuseIdentifier: "TVTableViewCell")
		tableView.register(TVSubTableViewCell.self, forCellReuseIdentifier: "TVSubTableViewCell")
		tableView.rowHeight = UITableView.automaticDimension
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

			let image = trendTVList.randomElement()?.poster ?? ""
			let url = URL(string: "https://image.tmdb.org/t/p/w500\(image)")
			cell.posterImageView.kf.setImage(with: url)


			return cell

		} else {

			let cell = tableView.dequeueReusableCell(withIdentifier: "TVSubTableViewCell", for: indexPath) as! TVSubTableViewCell

			cell.collectionView.dataSource = self
			cell.collectionView.delegate = self
			cell.collectionView.register(TVSubCollectionViewCell.self, forCellWithReuseIdentifier: "TVSubCollectionViewCell")
			cell.collectionView.tag = indexPath.row

			cell.titleLabel.text = TVListType.allCases[indexPath.row].rawValue

			cell.collectionView.reloadData()
			return cell

		}
	}


}

//테이블뷰내 컬렉션뷰 (indexPath.row 1부터)
extension TVViewController: UICollectionViewDataSource, UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		switch collectionView.tag {
		case 1: return trendTVList.count
		case 2: return topRatedTVList.count
		case 3: return popularTVList.count
		default: return 0
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TVSubCollectionViewCell", for: indexPath) as! TVSubCollectionViewCell

		switch collectionView.tag {
		case 1:			
			let image = trendTVList[indexPath.item].poster
			let url = URL(string: "https://image.tmdb.org/t/p/w500\(image)")
			cell.posterImageView.kf.setImage(with: url)
			return cell
		case 2:
			let image = topRatedTVList[indexPath.item].poster
			let url = URL(string: "https://image.tmdb.org/t/p/w500\(image)")
			cell.posterImageView.kf.setImage(with: url)
			return cell
		case 3:
			let image = popularTVList[indexPath.item].poster
			let url = URL(string: "https://image.tmdb.org/t/p/w500\(image)")
			cell.posterImageView.kf.setImage(with: url)
			return cell
		default:
			return cell
		}
	}
}
