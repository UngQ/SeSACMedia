//
//  ProfileTableViewCell.swift
//  SeSACMedia
//
//  Created by ungQ on 2/8/24.
//

import UIKit
import SnapKit

final class ProfileTableViewCell: UITableViewCell {

	var testView = ProfileLabelAndTextFieldView()

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)

		configureHierarchy()
		configureLayout()
	}


	func configureHierarchy() {
		contentView.addSubview(testView)
	}

	func configureLayout() {
		testView.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}
	}





	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
