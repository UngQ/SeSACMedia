//
//  TVView.swift
//  SeSACMedia
//
//  Created by ungQ on 2/2/24.
//

import UIKit

final class TVView: BaseView {

	let mainTableView = UITableView()

	override func configureView() {
		requestData()
		TMDBAPIManager.dispatchGroup.notify(queue: .main) {
			self.mainTableView.reloadData()
		}
	}

	override func configureHierarchy() {
		addSubview(mainTableView)
	}

	override func configureLayout() {
		mainTableView.snp.makeConstraints { make in
			make.edges.equalTo(safeAreaLayoutGuide)
		}
	}

	func requestData() {
		TMDBAPIManager.shared.request(type: TVModel.self, api: .airingToday) {
			TVViewController.airingTodayList = $0.results ?? []
			TVViewController.mainTV = TVViewController.airingTodayList.randomElement()!
		}

		TMDBAPIManager.shared.request(type: TVModel.self, api: .trend) {
			TVViewController.trendList = $0.results ?? []
		}

		TMDBAPIManager.shared.request(type: TVModel.self, api: .topRated) {
			TVViewController.topRatedList = $0.results ?? []
		}

		TMDBAPIManager.shared.request(type: TVModel.self, api: .popular) {
			TVViewController.popularList = $0.results ?? []
		}
	}

	

}
