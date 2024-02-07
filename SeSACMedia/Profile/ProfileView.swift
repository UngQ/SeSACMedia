//
//  ProfileView.swift
//  SeSACMedia
//
//  Created by ungQ on 2/7/24.
//

import UIKit

enum ProfileInfoType: CaseIterable {
	case name
	case nickname
	case email

	var title: String {
		switch self {
		case .name:
			return "이름"
		case .nickname:
			return "닉네임"
		case .email:
			return "이메일"
		}
	}
}

class ProfileView: BaseView {


	let profileImageView = UIImageView()

	let nameView = ProfileLabelAndTextFieldView()
	let nicknameView = ProfileLabelAndTextFieldView()
	let emailView = ProfileLabelAndTextFieldView()

	lazy var views: [ProfileLabelAndTextFieldView] = [nameView, nicknameView, emailView]


	override init(frame: CGRect) {
		super.init(frame: frame)
	}

	override func configureHierarchy() {
		addSubview(profileImageView)
		addSubview(nameView)
		addSubview(nicknameView)
		addSubview(emailView)

	}


	override func configureLayout() {
		
		profileImageView.snp.makeConstraints { make in
			make.centerX.equalToSuperview()
			make.top.equalTo(safeAreaLayoutGuide)
			make.size.equalTo(80)
		}
		
		nameView.snp.makeConstraints { make in
			make.top.equalTo(profileImageView.snp.bottom).offset(4)
			make.horizontalEdges.equalToSuperview()
			make.height.equalTo(40)
		}
		
		nicknameView.snp.makeConstraints { make in
			make.top.equalTo(nameView.snp.bottom).offset(4)
			make.horizontalEdges.equalToSuperview()
			make.height.equalTo(40)
		}

		emailView.snp.makeConstraints { make in
			make.top.equalTo(nicknameView.snp.bottom).offset(4)
			make.horizontalEdges.equalToSuperview()
			make.height.equalTo(40)
		}
	}


	override func configureView() {

		for i in 0...ProfileInfoType.allCases.count - 1 {
			views[i].keyLabel.text = ProfileInfoType.allCases[i].title

			views[i].modifyButton.addTarget(self, action: #selector(modifyButtonClicked), for: .touchUpInside)
		}



	}

	@objc func modifyButtonClicked() {
		print("콜록")
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	

}
