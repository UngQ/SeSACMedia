//
//  ModifyProfileViewController.swift
//  SeSACMedia
//
//  Created by ungQ on 2/7/24.
//

import UIKit
import SnapKit

class ModifyProfileViewController: BaseViewController {

	let inputTextField = UITextField()
	let okButton = UIButton()

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
		
		valueSpace!(inputTextField.text!)

		dismiss(animated: true)

//		Push, Pop으로 구현시 런타임오류
//		UINavigationController().popViewController(animated: true)
	}


}
