//
//  SeasonInfo.swift
//  SeSACMedia
//
//  Created by ungQ on 2/6/24.
//

import UIKit
import SnapKit

class SeasonInfoView: BaseView {

	let seasonTableView = UITableView()

	
	override func configureHierarchy() {
		addSubview(seasonTableView)
	}

	override func configureLayout() {
		seasonTableView.snp.makeConstraints { make in
			make.edges.equalTo(safeAreaLayoutGuide)
		}
	}


	override func configureView() {
		seasonTableView.backgroundColor = .darkGray

	}
}
