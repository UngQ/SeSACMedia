//
//  PosterImageView.swift
//  SeSACMedia
//
//  Created by ungQ on 1/30/24.
//

import UIKit

class PosterImageView: UIImageView {

	override init(frame: CGRect) {
		super.init(frame: frame)


		clipsToBounds = true
		backgroundColor = .black
		contentMode = .scaleAspectFill
		tintColor = .white
		layer.cornerRadius = 12
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
