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
	let nameLabel = UILabel()

	override init(frame: CGRect) {
		super.init(frame: frame)

		configureHierarchy()
		configureLayout()
		configureCell()

	}


	func configureHierarchy() {
		contentView.addSubview(posterImageView)
		contentView.addSubview(nameLabel)
	}

	func configureLayout() {
		posterImageView.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}

		nameLabel.snp.makeConstraints { make in
			make.horizontalEdges.bottom.equalToSuperview().inset(4)
			make.height.equalTo(16)
		}

	}

	func configureCell() {
		nameLabel.textAlignment = .center
		nameLabel.font = .boldSystemFont(ofSize: 11)
		nameLabel.layer.cornerRadius = 6
		nameLabel.layer.masksToBounds = true

	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
