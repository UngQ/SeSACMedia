//
//  SeasonAndEpisodeTableViewCell.swift
//  SeSACMedia
//
//  Created by ungQ on 2/6/24.
//

import UIKit
import SnapKit

final class SeasonOrEpisodeTableViewCell: UITableViewCell {

	let posterImageView = PosterImageView(frame: .zero)
	let titleLabel = UILabel()
	let overviewTextView = UILabel()

	var seasonNumber: Int = 0

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)

		configureHierarchy()
		configureLayout()
		configureCell()
	}
	

	func configureHierarchy() {
		addSubview(posterImageView)
		addSubview(titleLabel)
		addSubview(overviewTextView)
	}

	func configureLayout() {
		posterImageView.snp.makeConstraints { make in
			make.width.equalTo(UIScreen.main.bounds.width / 3)
			make.height.equalTo(posterImageView.snp.width).multipliedBy(1.4)
			make.top.leading.equalTo(safeAreaLayoutGuide).offset(8)
		}

		titleLabel.snp.makeConstraints { make in
			make.top.trailing.equalTo(safeAreaLayoutGuide).offset(8)
			make.leading.equalTo(posterImageView.snp.trailing).offset(4)
			make.height.equalTo(20)

		}

		overviewTextView.snp.makeConstraints { make in
			make.top.equalTo(titleLabel.snp.bottom).offset(2)
			make.leading.equalTo(posterImageView.snp.trailing).offset(4)
			make.trailing.bottom.lessThanOrEqualTo(safeAreaLayoutGuide).offset(-8)

		}


	}

	func configureCell() {
		backgroundColor = .clear
		posterImageView.backgroundColor = .black
		
		titleLabel.text = "test"
		titleLabel.font = .boldSystemFont(ofSize: 16)
		titleLabel.textColor = .white

		overviewTextView.backgroundColor = .clear
		overviewTextView.textColor = .white
		overviewTextView.font = .boldSystemFont(ofSize: 13)
		overviewTextView.numberOfLines = 0
	}





	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
