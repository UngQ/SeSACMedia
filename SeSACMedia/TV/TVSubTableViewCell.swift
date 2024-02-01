//
//  TVSubTableViewCell.swift
//  SeSACMedia
//
//  Created by ungQ on 1/30/24.
//

import UIKit

class TVSubTableViewCell: UITableViewCell {
	
	let titleLabel = UILabel()
	let collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		configureHierarchy()
		configureLayout()
		configureCell()

	}

	func configureHierarchy() {
		contentView.addSubview(titleLabel)
		contentView.addSubview(collectionView)

	}

	func configureLayout() {
		titleLabel.snp.makeConstraints { make in
			make.top.equalToSuperview()
			make.horizontalEdges.equalToSuperview().inset(8)
			make.height.equalTo(20)
		}

		collectionView.snp.makeConstraints { make in
			make.top.equalTo(titleLabel.snp.bottom)
			make.height.equalTo(140)
			make.horizontalEdges.bottom.equalToSuperview().inset(8)

		}
	}

	func configureCell() {
		titleLabel.font = .boldSystemFont(ofSize: 14)
		titleLabel.textColor = .white
		self.backgroundColor = .black
		collectionView.backgroundColor = .black
	}

	static func configureCollectionViewLayout() -> UICollectionViewLayout {
		let layout = UICollectionViewFlowLayout()
		layout.itemSize = CGSize(width: 100, height: 140)
		layout.minimumLineSpacing = 4
		layout.minimumInteritemSpacing = 0
		layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
		layout.scrollDirection = .horizontal
		return layout
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
