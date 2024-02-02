//
//  TVDetailView.swift
//  SeSACMedia
//
//  Created by ungQ on 2/2/24.
//

import UIKit

class TVDetailView: BaseView {
	
	let posterImageView = PosterImageView(frame: .zero)
	let overviewTextView = UITextView()
	let mainTableView = UITableView()

	let id = UserDefaults.standard.integer(forKey: "ID")

	override func configureHierarchy() {
		addSubview(posterImageView)
		addSubview(overviewTextView)
		addSubview(mainTableView)
	}

	override func configureLayout() {
		posterImageView.snp.makeConstraints { make in
			make.width.equalTo(UIScreen.main.bounds.width / 3)
			make.height.equalTo(posterImageView.snp.width).multipliedBy(1.4)
			make.top.leading.equalTo(safeAreaLayoutGuide).inset(8)
		}

		overviewTextView.snp.makeConstraints { make in
			make.leading.equalTo(posterImageView.snp.trailing).offset(8)
			make.top.equalTo(safeAreaLayoutGuide).offset(8)
			make.trailing.equalTo(safeAreaLayoutGuide).inset(8)
			make.height.equalTo(posterImageView.snp.height)
		}

		mainTableView.snp.makeConstraints { make in
			make.top.equalTo(posterImageView.snp.bottom).offset(8)
			make.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
		}
	}

	override func configureView() {

		let group = DispatchGroup()

		group.enter()

		
		TMDBAPIManager.shared.fetchTVDetailInfo(id: id) {
			TVDetailViewController.selectedTV = $0
			group.leave()
		}

		group.enter()
		TMDBAPIManager.shared.fetchCastInfo(id: id) {
			TVDetailViewController.castList = $0
			group.leave()
		}

		group.enter()
		TMDBAPIManager.shared.fetchTVList(api: .recommend(id: id)) {
			TVDetailViewController.recommendList = $0
			group.leave()
		}

		group.notify(queue: .main) {
			self.configureTVDetail()
			self.mainTableView.reloadData()
		}

		mainTableView.backgroundColor = .black
		overviewTextView.backgroundColor = .clear
	}

	func configureTVDetail() {
		if let image = TVDetailViewController.selectedTV.poster {
			let url = URL(string: "https://image.tmdb.org/t/p/w500\(image)")
			posterImageView.kf.setImage(with: url)
		}

		overviewTextView.text = TVDetailViewController.selectedTV.overview
		overviewTextView.textColor = .white
		overviewTextView.font = .boldSystemFont(ofSize: 15)
		overviewTextView.isEditable = false
		overviewTextView.isScrollEnabled = true
		overviewTextView.textContainerInset = .zero
		//		overviewTextView.textContainer.lineFragmentPadding = 0

	}





	
}
