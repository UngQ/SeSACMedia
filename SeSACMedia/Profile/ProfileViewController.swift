//
//  ProfileViewController.swift
//  SeSACMedia
//
//  Created by ungQ on 2/7/24.
//

import UIKit
import SnapKit

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


class ProfileViewController: BaseViewController {

	let profileImageView = UIImageView()
//
//	let nameView = ProfileLabelAndTextFieldView()
//	let nicknameView = ProfileLabelAndTextFieldView()
//	let emailView = ProfileLabelAndTextFieldView()
//
//	lazy var views: [ProfileLabelAndTextFieldView] = [nameView, nicknameView, emailView]

	var testView: [ProfileLabelAndTextFieldView] = [ProfileLabelAndTextFieldView(),
													ProfileLabelAndTextFieldView(),
													ProfileLabelAndTextFieldView()]


    override func viewDidLoad() {
        super.viewDidLoad()


		
    }


	override func configureHierarchy() {
		view.addSubview(profileImageView)
//		view.addSubview(nameView)
//		view.addSubview(nicknameView)
//		view.addSubview(emailView)

		view.addSubview(testView[0])
		view.addSubview(testView[1])
		view.addSubview(testView[2])

	}


	override func configureLayout() {

		profileImageView.snp.makeConstraints { make in
			make.centerX.equalToSuperview()
			make.top.equalTo(view.safeAreaLayoutGuide)
			make.size.equalTo(80)
		}

//		nameView.snp.makeConstraints { make in
//			make.top.equalTo(profileImageView.snp.bottom).offset(4)
//			make.horizontalEdges.equalToSuperview()
//			make.height.equalTo(40)
//		}
//
//		nicknameView.snp.makeConstraints { make in
//			make.top.equalTo(nameView.snp.bottom).offset(4)
//			make.horizontalEdges.equalToSuperview()
//			make.height.equalTo(40)
//		}
//
//		emailView.snp.makeConstraints { make in
//			make.top.equalTo(nicknameView.snp.bottom).offset(4)
//			make.horizontalEdges.equalToSuperview()
//			make.height.equalTo(40)
//		}

		testView[0].snp.makeConstraints { make in
			make.top.equalTo(profileImageView.snp.bottom).offset(4)
			make.horizontalEdges.equalToSuperview()
			make.height.equalTo(40)
		}

		testView[1].snp.makeConstraints { make in
			make.top.equalTo(testView[0].snp.bottom).offset(4)
			make.horizontalEdges.equalToSuperview()
			make.height.equalTo(40)
		}

		testView[2].snp.makeConstraints { make in
			make.top.equalTo(testView[1].snp.bottom).offset(4)
			make.horizontalEdges.equalToSuperview()
			make.height.equalTo(40)
		}
	}


	override func configureView() {

		for i in 0...ProfileInfoType.allCases.count - 1 {
			testView[i].keyLabel.text = ProfileInfoType.allCases[i].title
			testView[i].modifyButton.tag = i
			testView[i].modifyButton.addTarget(self, action: #selector(modifyButtonClicked), for: .touchUpInside)
		}



	}


	@objc func modifyButtonClicked(_ sender: UIButton) {

		let vc = ModifyProfileViewController()

		vc.valueSpace = { value in
			self.testView[sender.tag].valueLabel.text = value
		}


		present(vc, animated: true)
//		navigationController?.pushViewController(ModifyProfileViewController(), animated: true)
	}





}
