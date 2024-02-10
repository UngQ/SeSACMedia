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
	case airingToday
	case trend
	case topRated
	case popular

	var title: String {
		switch self {
		case .airingToday:
			return "현재 방영 중"
		case .trend:
			return "이번 주 트렌드"
		case .topRated:
			return "이번 주 최고 평점"
		case .popular:
			return "이번 주 가장 인기 있는!"
		}
	}

	var list: [TV] {
		switch self {
		case .airingToday:
			return TVViewController.airingTodayList
		case .trend:
			return TVViewController.trendList
		case .topRated:
			return TVViewController.topRatedList
		case .popular:
			return TVViewController.popularList
		}
	}

	var count: Int {
		switch self {
		case .airingToday:
			return TVViewController.airingTodayList.count 
		case .trend:
			return TVViewController.trendList.count
		case .topRated:
			return TVViewController.topRatedList.count
		case .popular:
			return TVViewController.popularList.count
		}
	}
}

final class TVViewController: BaseViewController {

	static var airingTodayList: [TV] = []
	static var trendList: [TV] = []
	static var topRatedList: [TV] = []
	static var popularList: [TV] = []

	static var mainTV: TV = TV(id: 0, name: "", posterPath: "")

	static var tvID: Int = 0 {
		didSet {
			UserDefaults.standard.setValue(tvID, forKey: "ID")
		}
	}

	static var tvTitle: String = "" {
		didSet {
			UserDefaults.standard.setValue(tvTitle, forKey: "Title")
		}
	}

	let mainView = TVView()

	override func loadView() {
		view = mainView
	}

    override func viewDidLoad() {
        super.viewDidLoad()
    }

	override func configureView() {
		configureNavigationBar()
		configureTableView()
	}

	func configureTableView() {
		mainView.mainTableView.delegate = self
		mainView.mainTableView.dataSource = self
		mainView.mainTableView.register(TVTableViewCell.self, forCellReuseIdentifier: TVTableViewCell.identifier)
		mainView.mainTableView.register(TVSubTableViewCell.self, forCellReuseIdentifier: TVSubTableViewCell.identifier)
		mainView.mainTableView.backgroundColor = .black
	}

	func configureNavigationBar() {
		navigationController?.navigationBar.tintColor = .white
		let navigationBarAppearance = UINavigationBarAppearance()
		navigationBarAppearance.backgroundColor = .red
		navigationBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
		navigationController!.navigationBar.standardAppearance = navigationBarAppearance
		navigationController!.navigationBar.scrollEdgeAppearance = navigationBarAppearance
		let navigationRightBarButton = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(navigationRightBarButtonClicked))
		navigationItem.rightBarButtonItem = navigationRightBarButton
		navigationItem.title = "nickname님 환영합니다"

		let backBarButton = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
		navigationItem.backBarButtonItem = backBarButton
	}

	@objc func navigationRightBarButtonClicked() {
		navigationController?.pushViewController(SearchViewController(), animated: true)
	}
}

//테이블뷰


extension TVViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		if indexPath.row == 0 {
			return UITableView.automaticDimension
		}
		return (UIScreen.main.bounds.width / 3 - 8) * 1.4 + 30
	}


	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

		return TVListType.allCases.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if indexPath.row == 0 {
			let cell = tableView.dequeueReusableCell(withIdentifier: TVTableViewCell.identifier, for: indexPath) as! TVTableViewCell
			cell.selectionStyle = .none
			
			guard let main = TVListType(rawValue: 0)?.list.randomElement() else { return cell }
			TVViewController.mainTV = main
			guard let path = main.posterPath else {
				cell.posterImageView.contentMode = .scaleAspectFit
				cell.posterImageView.image = UIImage(systemName: "xmark")
				return cell }
			let url = URL(string: "https://image.tmdb.org/t/p/w500\(path)")
			cell.posterImageView.kf.setImage(with: url)
			cell.posterImageView.contentMode = .scaleAspectFill

			return cell

		} else {

			let cell = tableView.dequeueReusableCell(withIdentifier: TVSubTableViewCell.identifier, for: indexPath) as! TVSubTableViewCell
			cell.selectionStyle = .none
			cell.collectionView.dataSource = self
			cell.collectionView.delegate = self
			cell.collectionView.register(TVSubCollectionViewCell.self, forCellWithReuseIdentifier: TVSubCollectionViewCell.identifier)
			cell.collectionView.tag = indexPath.row

			if let listType = TVListType(rawValue: cell.collectionView.tag) {
				cell.titleLabel.text = listType.title
			}

			cell.collectionView.reloadData()
			return cell

		}
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if indexPath.row == 0 {

			TVViewController.tvID = TVViewController.mainTV.id
			TVViewController.tvTitle = TVViewController.mainTV.name
			navigationController?.pushViewController(TVDetailViewController(), animated: true)
		}
	}
}

//테이블뷰내 컬렉션뷰 (indexPath.row, collectionview.tag 1부터)
extension TVViewController: UICollectionViewDataSource, UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

		if let listType = TVListType(rawValue: collectionView.tag) {
			return listType.count
		}
		return 0
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TVSubCollectionViewCell.identifier, for: indexPath) as! TVSubCollectionViewCell

		if let listType = TVListType(rawValue: collectionView.tag) {
			configureCollectionViewCell(cell: cell, list: listType.list, item: indexPath.row)
		}

		return cell
	}

	func configureCollectionViewCell(cell: TVSubCollectionViewCell, list: [TV], item: Int) {

		guard let image = list[item].posterPath else { 
			cell.posterImageView.image = UIImage(systemName: "xmark")
			cell.posterImageView.contentMode = .scaleAspectFit
			return }
		let url = URL(string: "https://image.tmdb.org/t/p/w500\(image)")
		cell.posterImageView.kf.setImage(with: url)
		cell.posterImageView.contentMode = .scaleAspectFill

	}


	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

		if let listType = TVListType(rawValue: collectionView.tag) {
			TVViewController.tvID = listType.list[indexPath.row].id
			TVViewController.tvTitle = listType.list[indexPath.row].name
		}

		let vc = TVDetailViewController()
		navigationController?.pushViewController(vc, animated: true)

	}
}
