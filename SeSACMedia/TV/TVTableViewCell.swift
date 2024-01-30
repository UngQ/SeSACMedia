//
//  TVTableViewCell.swift
//  SeSACMedia
//
//  Created by ungQ on 1/30/24.
//

import UIKit
import SnapKit

class TVTableViewCell: UITableViewCell {

	let posterImageView = PosterImageView(frame: .zero)

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)

		configureHierarchy()
		configureLayout()

	}

	func configureHierarchy() {
		contentView.addSubview(posterImageView)
	}

	func configureLayout() {
		posterImageView.snp.makeConstraints { make in
			make.edges.equalToSuperview().inset(16)
			make.width.equalTo(UIScreen.main.bounds.width)
			make.height.equalTo(posterImageView.snp.width).multipliedBy(1.4)
		}

	}

	func configureCell() {

	}



	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
