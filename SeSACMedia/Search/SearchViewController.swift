//
//  SearchViewController.swift
//  SeSACMedia
//
//  Created by ungQ on 2/3/24.
//

import UIKit
import SnapKit

class SearchViewController: BaseViewController {

	let searchBar = UISearchBar()
	let searchHistoryCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    override func viewDidLoad() {
        super.viewDidLoad()


    }

	override func configureHierarchy() {
		view.addSubview(searchBar)
		view.addSubview(searchHistoryCollectionView)
	}

	override func configureLayout() {
		searchBar.snp.makeConstraints { make in
			make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
		}
		searchHistoryCollectionView
	}

	override func configureView() {
		searchBar.searchBarStyle = .minimal
		searchBar.placeholder = "검색어를 입력해주세요"
	}

}
