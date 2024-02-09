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
	case email
	case nickname
	case test
	case test3

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
		case .test3:
			return "Hi"
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

		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(profileImageTapped))

		mainView.profileImageView.addGestureRecognizer(tapGesture)
		mainView.profileImageView.isUserInteractionEnabled = true

		

		for i in 0...ProfileInfoType.allCases.count - 1 {
			mainView.testView[i].modifyButton.addTarget(self, action: #selector(modifyButtonClicked), for: .touchUpInside)
		}

		mainView.tableView.dataSource = self
		mainView.tableView.delegate = self
		mainView.tableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: ProfileTableViewCell.identifier)

	}

	@objc func profileImageTapped() {

		let vc = ProfileImageSearchViewController()
		vc.valueSpace = {
			let url = $0
			self.mainView.profileImageView.kf.setImage(with: url)
		}
		
		present(vc, animated: true)
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


extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return ProfileInfoType.allCases.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.identifier, for: indexPath) as! ProfileTableViewCell

		cell.testView.keyLabel.text = ProfileInfoType.allCases[indexPath.row].title
		cell.testView.modifyButton.tag = indexPath.row

		cell.testView.modifyButton.addTarget(self, action: #selector(modifyButtonClickedInTableView), for: .touchUpInside)

		return cell
	}

	@objc func modifyButtonClickedInTableView(sender: UIButton) {
		let vc = ModifyProfileViewController()

		vc.valueSpace = { value in
			let cell = self.mainView.tableView.cellForRow(at: IndexPath(row: sender.tag, section: 0)) as! ProfileTableViewCell
			cell.testView.valueLabel.text = value
		}

		present(vc, animated: true)
	}

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		40
	}




}
