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
			return "출연진"
		case .recommend:
			return "비슷한 콘텐츠"
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
}

final class TVDetailViewController: BaseViewController {

	var selectedTV: DetailTVModel = DetailTVModel(id: 0, name: "", overview: "", seasons: nil, poster: "", firstAirDate: "", lastAirDate: "", voteAverage: 0)
	var castList: [Cast] = []
	var recommendList: [TV] = []
	var videoData: [Result] = []

	let id = UserDefaults.standard.integer(forKey: "ID")

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

		mainView.moreInfoButton.addTarget(self, action: #selector(moreInfoButtonClicked), for: .touchUpInside)
		mainView.videoPlayButton.addTarget(self, action: #selector(videoPlayButtonClicked), for: .touchUpInside)

		requestData()

		TMDBAPIManager.dispatchGroup.notify(queue: .main) {
			self.configureTVDetail()
			self.mainView.mainTableView.reloadData()
		}

	}

	@objc func moreInfoButtonClicked() {
		let vc = SeasonOrEpisodeInfoViewController()
		let nav = UINavigationController(rootViewController: vc)
		present(nav, animated: true)
		print(id)
	}

	@objc func videoPlayButtonClicked(sender: UIButton) {
		present(VideoViewController(), animated: true)
	}

	func requestData() {

		TMDBAPIManager.shared.request(type: DetailTVModel.self, api: .detailInfo(id: id)) {
			self.selectedTV = $0
		}

		TMDBAPIManager.shared.request(type: CastModel.self, api: .cast(id: id)) {
			self.castList = $0.cast
		}

		TMDBAPIManager.shared.request(type: TVModel.self, api: .recommend(id: id)) {
			self.recommendList = $0.results ?? []
		}

		TMDBAPIManager.shared.request(type: VideoModel.self, api: .video(id: id)) {
			self.videoData = $0.results ?? []
		}

	}

	func configureTVDetail() {
		if let image = selectedTV.poster {
			let url = URL(string: "https://image.tmdb.org/t/p/w500\(image)")
			mainView.posterImageView.kf.setImage(with: url)
		}
		mainView.overviewTextView.text = selectedTV.overview

		if videoData != [] {
			mainView.videoPlayButton.isHidden = false
			UserDefaults.standard.setValue(videoData[0].key, forKey: "Key")
		}

	}

	func configureNavigationBar() {
		navigationItem.title = UserDefaults.standard.string(forKey: "Title")
		navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
		let backBarButton = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
		navigationItem.backBarButtonItem = backBarButton
	}
}


extension TVDetailViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return DetailInfoType.allCases.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = mainView.mainTableView.dequeueReusableCell(withIdentifier: "TableViewCellInDetail", for: indexPath) as! TVSubTableViewCell

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

		if indexPath.row == 0 {
			return (UIScreen.main.bounds.width / 3 - 8) * 1.4
		} else {
			return mainView.mainTableView.bounds.height - (UIScreen.main.bounds.width / 3 - 8) * 1.4
		}
	}


}

extension TVDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {


		if collectionView.tag == 0 {
			return castList.count
		} else {
			return recommendList.count
		}

	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCellInDetail", for: indexPath) as! TVSubCollectionViewCell


		cell.posterImageView.contentMode = .scaleAspectFit


		if collectionView.tag == DetailInfoType.cast.rawValue {
			cell.posterImageView.image = UIImage(systemName: "person.fill.questionmark")
			guard let image = castList[indexPath.row].profilePath else { return cell }
			let url = URL(string: "https://image.tmdb.org/t/p/w500\(image)")
			cell.posterImageView.kf.setImage(with: url)
			cell.posterImageView.contentMode = .scaleAspectFill
			cell.nameLabel.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)

			cell.nameLabel.textColor = .white
			cell.nameLabel.text = castList[indexPath.row].name
			
		} else if collectionView.tag == DetailInfoType.recommend.rawValue {
			cell.posterImageView.image = UIImage(systemName: "xmark")
			guard let image = recommendList[indexPath.row].posterPath else { return cell }
			let url = URL(string: "https://image.tmdb.org/t/p/w500\(image)")
			cell.posterImageView.kf.setImage(with: url)
			cell.posterImageView.contentMode = .scaleAspectFill
		}

		return cell
	}

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

		if collectionView.tag == 1 {
			
			tvID = recommendList[indexPath.row].id
			tvTitle = recommendList[indexPath.row].name

			let vc = TVDetailViewController()
			navigationController?.pushViewController(vc, animated: true)
		}
	}
}
