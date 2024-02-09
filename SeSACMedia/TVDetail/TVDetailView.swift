//
//  TVDetailView.swift
//  SeSACMedia
//
//  Created by ungQ on 2/6/24.
//

import UIKit
import SnapKit

class TVDetailView: BaseView {


	let posterImageView = PosterImageView(frame: .zero)
	let moreInfoButton = UIButton()
	let videoPlayButton = UIButton()
	let overviewTextView = UITextView()
	let mainTableView = UITableView()


	override func configureHierarchy() {
		addSubview(posterImageView)
		addSubview(moreInfoButton)
		addSubview(overviewTextView)
		addSubview(videoPlayButton)
		addSubview(mainTableView)
		addSubview(moreInfoButton)
	}

	override func configureLayout() {
		posterImageView.snp.makeConstraints { make in
			make.width.equalTo(UIScreen.main.bounds.width / 3)
			make.height.equalTo(posterImageView.snp.width).multipliedBy(1.4)
			make.top.leading.equalTo(safeAreaLayoutGuide).inset(8)
		}
		moreInfoButton.snp.makeConstraints { make in
			make.width.height.equalTo(24)
			make.top.equalTo(posterImageView.snp.top).offset(4)
			make.trailing.equalTo(posterImageView.snp.trailing).offset(-4)
		}

		videoPlayButton.snp.makeConstraints { make in
			make.width.size.equalTo(60)
			make.centerX.centerY.equalTo(posterImageView)
//			make.bottom.equalTo(posterImageView.snp.bottom)
//			make.trailing.equalTo(posterImageView.snp.trailing)
		}

		overviewTextView.snp.makeConstraints { make in
			make.leading.equalTo(posterImageView.snp.trailing).offset(8)
			make.top.equalTo(safeAreaLayoutGuide).offset(8)
			make.trailing.equalTo(safeAreaLayoutGuide).inset(8)
			make.height.equalTo(posterImageView.snp.height)
		}

		mainTableView.snp.makeConstraints { make in
			make.top.equalTo(posterImageView.snp.bottom).offset(8)
			make.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
		}
	}

	override func configureView() {
		mainTableView.backgroundColor = .black

		moreInfoButton.setBackgroundImage(UIImage(systemName: "info.circle"), for: .normal)
		moreInfoButton.tintColor = .white

		overviewTextView.backgroundColor = .clear
		overviewTextView.textColor = .white
		overviewTextView.font = .boldSystemFont(ofSize: 15)
		overviewTextView.isEditable = false
		overviewTextView.isScrollEnabled = true
		overviewTextView.textContainerInset = .zero


		videoPlayButton.setBackgroundImage(UIImage(systemName: "play.square.fill"), for: .normal)
		videoPlayButton.layer.opacity = 0.4
		videoPlayButton.tintColor = .white
		videoPlayButton.isHidden = true


	}
}
