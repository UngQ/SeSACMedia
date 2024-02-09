//
//  ProfileImageCollectionViewCell.swift
//  SeSACMedia
//
//  Created by ungQ on 2/8/24.
//

import UIKit
import SnapKit

class ProfileImageCollectionViewCell: UICollectionViewCell {

	let imageView = PosterImageView(frame: .zero)

	var url: URL?

	override init(frame: CGRect) {
		super.init(frame: frame)
		configureHierarchy()
		configureLayout()
		configureCell()
	}

	func configureHierarchy() {
		addSubview(imageView)
	}

	func configureLayout() {
		imageView.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}
	}


	func configureCell() {
		imageView.backgroundColor = .red
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
