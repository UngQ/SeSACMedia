//
//  ModifyProfileViewController.swift
//  SeSACMedia
//
//  Created by ungQ on 2/7/24.
//

import UIKit
import SnapKit

final class ModifyProfileViewController: BaseViewController {

	let inputTextField = UITextField()
	let okButton = UIButton()

	var titleSpace: String?
	var valueSpace: ((String) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

		view.backgroundColor = .lightGray
        
    }


	override func configureHierarchy() {
		view.addSubview(inputTextField)
		view.addSubview(okButton)
	}

	override func configureLayout() {
		inputTextField.snp.makeConstraints { make in
			make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(4)
		}

		okButton.snp.makeConstraints { make in
			make.top.equalTo(inputTextField.snp.bottom).offset(4)
			make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
		}

	}

	override func configureView() {
		inputTextField.placeholder = "입력해주세요"


		okButton.backgroundColor = .black
		okButton.setTitle("수정", for: .normal)
		okButton.setTitleColor(.white, for: .normal)
		okButton.tintColor = .white

		okButton.addTarget(self, action: #selector(okButtonClicked), for: .touchUpInside)
	}

	@objc func okButtonClicked() {
		
		alert(text: inputTextField.text!)

	}

	


}


extension ModifyProfileViewController {
	func alert(text: String) {

		let alert = UIAlertController(title: "\(titleSpace!)", message: "변경 하시겠습니까?", preferredStyle: .alert)
		let okButton = UIAlertAction(title: "확인", style: .default) { _ in
			self.valueSpace!(text)
			self.dismiss(animated: true)
		}
		let cancelButton = UIAlertAction(title: "취소", style: .cancel)

		alert.addAction(okButton)
		alert.addAction(cancelButton)

		present(alert, animated: true)
	}
}
