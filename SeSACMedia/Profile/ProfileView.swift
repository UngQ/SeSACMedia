//
//  ProfileView.swift
//  SeSACMedia
//
//  Created by ungQ on 2/8/24.
//

import UIKit
import SnapKit

class ProfileView: BaseView {
	
	let profileImageView = UIImageView()

	var testView: [ProfileLabelAndTextFieldView] = []

	override init(frame: CGRect) {
		for i in 0...ProfileInfoType.allCases.count - 1 {
			testView.append(ProfileLabelAndTextFieldView())
		}

		super.init(frame: frame)
	}

	override func configureHierarchy() {
		addSubview(profileImageView)

		for i in 0...testView.count - 1 {
			addSubview(testView[i])
		}
	}

	override func configureLayout() {

		profileImageView.snp.makeConstraints { make in
			make.centerX.equalToSuperview()
			make.top.equalTo(safeAreaLayoutGuide)
			make.size.equalTo(80)
		}

		testView[0].snp.makeConstraints { make in
			make.top.equalTo(profileImageView.snp.bottom).offset(4)
			make.horizontalEdges.equalToSuperview()
			make.height.equalTo(40)
		}

		for i in 1...testView.count - 1 {
			testView[i].snp.makeConstraints { make in
				make.top.equalTo(testView[i-1].snp.bottom).offset(4)
				make.horizontalEdges.equalToSuperview()
				make.height.equalTo(40)
			}
		}
	}

	override func configureView() {

		for i in 0...ProfileInfoType.allCases.count - 1 {
			testView[i].keyLabel.text = ProfileInfoType.allCases[i].title
			testView[i].modifyButton.tag = i
		}
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
