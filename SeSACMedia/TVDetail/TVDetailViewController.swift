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

	let posterImageView = PosterImageView(frame: .zero)
	let overviewTextView = UITextView()
	let mainTableView = UITableView()

	let id = UserDefaults.standard.integer(forKey: "ID")

	var selectedTV: DetailTVModel = DetailTVModel(id: 0, name: "", overview: "", seasons: nil, poster: "", firstAirDate: "", lastAirDate: "", voteAverage: 0)
	var castList: [Cast] = []
	var recommendList: [RecommendModelResult] = []



	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)




	}

	override func viewDidLoad() {
		super.viewDidLoad()

		view.backgroundColor = .brown

		TMDBAPIManager.shared.fetchTVDetailInfo(id: self.id) {
			self.selectedTV = $0
			self.configureView()
		}

		let group = DispatchGroup()

		group.enter()
		TMDBAPIManager.shared.fetchCastInfo(id: id) {
			self.castList = $0
			group.leave()
		}

		group.enter()
		TMDBAPIManager.shared.fetchRecommendList(id: id) {
			self.recommendList = $0
			group.leave()
		}

		group.notify(queue: .main) {
			self.mainTableView.reloadData()

		}

	}

	override func configureHierarchy() {
		view.addSubview(posterImageView)
		view.addSubview(overviewTextView)
		view.addSubview(mainTableView)

	}

	override func configureLayout() {
		posterImageView.snp.makeConstraints { make in
			make.width.equalTo(UIScreen.main.bounds.width / 3)
			make.height.equalTo(posterImageView.snp.width).multipliedBy(1.4)
			make.top.leading.equalTo(view.safeAreaLayoutGuide).inset(8)
		}

		overviewTextView.snp.makeConstraints { make in
			make.leading.equalTo(posterImageView.snp.trailing).offset(8)
			make.top.equalTo(view.safeAreaLayoutGuide).offset(8)
			make.trailing.equalTo(view.safeAreaLayoutGuide).inset(8)
			make.height.equalTo(posterImageView.snp.height)

		}

		mainTableView.snp.makeConstraints { make in
			make.top.equalTo(posterImageView.snp.bottom).offset(8)
			make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)

		}

	}

	override func configureView() {

		navigationItem.title = selectedTV.name

		
		if let image = selectedTV.poster {
			let url = URL(string: "https://image.tmdb.org/t/p/w500\(image)")
			posterImageView.kf.setImage(with: url)
		}


		overviewTextView.backgroundColor = .clear
		overviewTextView.text = selectedTV.overview

		overviewTextView.textColor = .white
		overviewTextView.font = .boldSystemFont(ofSize: 15)
		overviewTextView.isEditable = false
		overviewTextView.isScrollEnabled = true
		overviewTextView.textContainerInset = .zero
		//		overviewTextView.textContainer.lineFragmentPadding = 0

		mainTableView.backgroundColor = .green
		mainTableView.delegate = self
		mainTableView.dataSource = self
		mainTableView.register(TVSubTableViewCell.self, forCellReuseIdentifier: "TableViewCellInDetail")
		mainTableView.rowHeight = UITableView.automaticDimension
	}


}


extension TVDetailViewController: UITableViewDelegate, UITableViewDataSource {

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		2
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = mainTableView.dequeueReusableCell(withIdentifier: "TableViewCellInDetail", for: indexPath) as! TVSubTableViewCell

		cell.collectionView.tag = indexPath.row
		cell.collectionView.dataSource = self
		cell.collectionView.delegate = self
		cell.collectionView.register(TVSubCollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCellInDetail")

		cell.collectionView.reloadData()
		if indexPath.row == 0 {
			cell.titleLabel.text = "출연진"
			return cell
		} else {
			cell.titleLabel.text = "비슷한 녀석들"
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
			return castList.count
		} else {
			if recommendList.count == 0 {
				print("리커멘트 없는거임")
				return 0
			} else {
				return recommendList.count
			}
		}

	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCellInDetail", for: indexPath) as! TVSubCollectionViewCell

		if collectionView.tag == 0 {
			if let image = castList[indexPath.item].profilePath {
				let url = URL(string: "https://image.tmdb.org/t/p/w500\(image)")
				cell.posterImageView.kf.setImage(with: url)
			} else {
				cell.posterImageView.image = UIImage(systemName: "xmark")
			}
		} else {
			if let image = recommendList[indexPath.item].posterPath {
				let url = URL(string: "https://image.tmdb.org/t/p/w500\(image)")
				cell.posterImageView.kf.setImage(with: url)
			} else {
				cell.posterImageView.image = UIImage(systemName: "xmark")
			}


		}
		return cell
	}

}
