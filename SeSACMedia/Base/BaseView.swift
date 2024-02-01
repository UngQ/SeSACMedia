//
//  BaseView.swift
//  SeSACMedia
//
//  Created by ungQ on 2/2/24.
//

import UIKit

class BaseView: UIView {

	override init(frame: CGRect) {
		super.init(frame: frame)

		backgroundColor = .black

		configureHierarchy()
		configureLayout()
		configureView()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func configureHierarchy() {

	}

	func configureLayout() {

	}

	func configureView() {

	}


}
