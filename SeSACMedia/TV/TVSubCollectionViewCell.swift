//
//  TVSubCollectionViewCell.swift
//  SeSACMedia
//
//  Created by ungQ on 1/30/24.
//

import UIKit
import SnapKit

class TVSubCollectionViewCell: UICollectionViewCell {

	let posterImageView = PosterImageView(frame: .zero)

	override init(frame: CGRect) {
		super.init(frame: frame)

		configureHierarchy()
		configureLayout()
		configureCell()

	}


	func configureHierarchy() {
		contentView.addSubview(posterImageView)
	}

	func configureLayout() {
		posterImageView.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}

	}

	func configureCell() {

	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
