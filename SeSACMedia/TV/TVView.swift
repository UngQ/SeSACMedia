//
//  TVView.swift
//  SeSACMedia
//
//  Created by ungQ on 2/2/24.
//

import UIKit

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
}

class TVView: BaseView {


	let mainTableView = UITableView()


	override func configureView() {
		

		let group = DispatchGroup()

		group.enter()
		TMDBAPIManager.shared.fetchTVList(api: .main) {
			TVViewController.airingTodayList = $0
			TVViewController.randomAiringToday = TVViewController.airingTodayList.randomElement()!
			group.leave()
		}

		group.enter()
		TMDBAPIManager.shared.fetchTVList(api: .trend) {
			TVViewController.trendList = $0
			group.leave()
		}

		group.enter()
		TMDBAPIManager.shared.fetchTVList(api: .topRated) {
			TVViewController.topRatedList = $0
			group.leave()
		}


		group.enter()
		TMDBAPIManager.shared.fetchTVList(api: .popular) {
			TVViewController.popularList = $0
			group.leave()
		}

		group.notify(queue: .main) {

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

	

}
