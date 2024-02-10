//
//  SeasonInfo.swift
//  SeSACMedia
//
//  Created by ungQ on 2/6/24.
//

import UIKit
import SnapKit

final class SeasonOrEpisodeInfoView: BaseView {

	let seasonOrEpisodeTableView = UITableView()

	
	override func configureHierarchy() {
		addSubview(seasonOrEpisodeTableView)
	}

	override func configureLayout() {
		seasonOrEpisodeTableView.snp.makeConstraints { make in
			make.edges.equalTo(safeAreaLayoutGuide)
		}
	}


	override func configureView() {
		seasonOrEpisodeTableView.backgroundColor = .darkGray

	}
}
