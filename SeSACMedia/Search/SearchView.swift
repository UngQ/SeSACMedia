//
//  SearchView.swift
//  SeSACMedia
//
//  Created by ungQ on 2/5/24.
//

import UIKit
import SnapKit

final class SearchView: BaseView {
	
	let searchBar = UISearchBar()
	let searchCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())


	override func configureHierarchy() {
		addSubview(searchBar)
		addSubview(searchCollectionView)
	}

	override func configureLayout() {
		searchBar.snp.makeConstraints { make in
			make.top.horizontalEdges.equalTo(safeAreaLayoutGuide)
		}

		searchCollectionView.snp.makeConstraints { make in
			make.top.equalTo(searchBar.snp.bottom)
			make.bottom.horizontalEdges.equalTo(safeAreaLayoutGuide)
		}

	}

	override func configureView() {
		searchBar.searchBarStyle = .minimal
		searchBar.searchTextField.textColor = .white
		searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "검색어를 입력해주세요.", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
		searchBar.barTintColor = .white

		searchCollectionView.backgroundColor = .black
		searchCollectionView.collectionViewLayout = TVSubTableViewCell.configureCollectionViewLayout(size: CGSize(width: UIScreen.main.bounds.width / 3 - 4  , height: (UIScreen.main.bounds.width / 3 - 4) * 1.4), direction: .vertical)
	}
}
