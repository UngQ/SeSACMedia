//
//  TVViewController.swift
//  SeSACMedia
//
//  Created by ungQ on 1/30/24.
//

import UIKit
import SnapKit
import Kingfisher

class TVViewController: BaseViewController {

	static var airingTodayList: [TV] = []
	static var randomAiringToday: TV = TV(id: 0, name: "", posterPath: "")

	static var trendList: [TV] = []
	static var topRatedList: [TV] = []
	static var popularList: [TV] = []
	
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

	let mainView = TVView()

	override func loadView() {
		view = mainView
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		configureNavigationBar()
    }

	override func configureView() {
		mainView.mainTableView.delegate = self
		mainView.mainTableView.dataSource = self
		mainView.mainTableView.register(TVTableViewCell.self, forCellReuseIdentifier: "TVTableViewCell")
		mainView.mainTableView.register(TVSubTableViewCell.self, forCellReuseIdentifier: "TVSubTableViewCell")
		mainView.mainTableView.rowHeight = UITableView.automaticDimension
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
	}

	@objc func navigationRightBarButtonClicked() {
		print("click")
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
			return configureFirstRowTableViewCell(cell: cell, list: TVViewController.airingTodayList)
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

			tvID = TVViewController.randomAiringToday.id
			tvTitle = TVViewController.randomAiringToday.name
			navigationController?.pushViewController(TVDetailViewController(), animated: true)

		}
	}

	func configureFirstRowTableViewCell(cell: TVTableViewCell, list: [TV]) -> TVTableViewCell {
		if let image = TVViewController.randomAiringToday.posterPath {
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
		case 1: return TVViewController.trendList.count
		case 2: return TVViewController.topRatedList.count
		case 3: return TVViewController.popularList.count
		default: return 0
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TVSubCollectionViewCell", for: indexPath) as! TVSubCollectionViewCell

		switch collectionView.tag {
		case 1:
			return configureCollectionViewCell(cell: cell, list: TVViewController.trendList, item: indexPath.item)
		case 2:
			return configureCollectionViewCell(cell: cell, list: TVViewController.topRatedList, item: indexPath.item)
		case 3:
			return configureCollectionViewCell(cell: cell, list: TVViewController.popularList, item: indexPath.item)
		default:
			return cell
		}
	}

	func configureCollectionViewCell(cell: TVSubCollectionViewCell, list: [TV], item: Int) -> TVSubCollectionViewCell {

		if let image = list[item].posterPath {
			let url = URL(string: "https://image.tmdb.org/t/p/w500\(image)")
			cell.posterImageView.kf.setImage(with: url)
		} else {
			cell.posterImageView.image = UIImage(systemName: "xmark")
		}

		return cell
	}


	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		tvID = TVViewController.trendList[indexPath.item].id

		switch collectionView.tag {
		case 1:
			tvID = TVViewController.trendList[indexPath.item].id
			tvTitle = TVViewController.trendList[indexPath.item].name
		case 2:
			tvID = TVViewController.topRatedList[indexPath.item].id
			tvTitle = TVViewController.topRatedList[indexPath.item].name
		case 3:
			tvID = TVViewController.popularList[indexPath.item].id
			tvTitle = TVViewController.popularList[indexPath.item].name
		default:
			print("오류")
		}

		let vc = TVDetailViewController()
		navigationController?.pushViewController(vc, animated: true)

	}
}
