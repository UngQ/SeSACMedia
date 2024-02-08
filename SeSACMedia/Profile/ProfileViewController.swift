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
	case test

	var title: String {
		switch self {
		case .name:
			return "이름"
		case .nickname:
			return "닉네임"
		case .email:
			return "이메일"
		case .test:
			return "test"
		}
	}
}


class ProfileViewController: BaseViewController {

	let mainView = ProfileView()

	override func loadView() {
		view = mainView
	}

	override func viewDidLoad() {
		super.viewDidLoad()

	}

	override func configureView() {
		for i in 0...ProfileInfoType.allCases.count - 1 {
			mainView.testView[i].modifyButton.addTarget(self, action: #selector(modifyButtonClicked), for: .touchUpInside)
		}
	}

	@objc func modifyButtonClicked(_ sender: UIButton) {

		let vc = ModifyProfileViewController()

		vc.valueSpace = { value in
			self.mainView.testView[sender.tag].valueLabel.text = value
		}

		present(vc, animated: true)
		//		navigationController?.pushViewController(ModifyProfileViewController(), animated: true)
	}





}
