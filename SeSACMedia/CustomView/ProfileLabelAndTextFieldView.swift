//
//  ProfileLabelAndTextFieldView.swift
//  SeSACMedia
//
//  Created by ungQ on 2/7/24.
//

import UIKit
import SnapKit

class ProfileLabelAndTextFieldView: BaseView {

	let keyLabel = UILabel()
	var valueLabel = UILabel()
	let modifyButton = UIButton()



	override init(frame: CGRect) {
		super.init(frame: frame)
	}


	override func configureHierarchy() {
		addSubview(keyLabel)
		addSubview(valueLabel)
		addSubview(modifyButton)
	}

	override func configureLayout() {
		keyLabel.snp.makeConstraints { make in
			make.top.bottom.equalToSuperview().offset(-4)
			make.leading.equalToSuperview().offset(4)
			make.height.equalToSuperview()
			make.width.equalTo(60)
		}
		

		valueLabel.snp.makeConstraints { make in
			make.top.bottom.equalToSuperview().offset(-4)
			make.leading.equalTo(keyLabel.snp.trailing).offset(4)


		}

		modifyButton.snp.makeConstraints { make in
			make.top.equalToSuperview().offset(4)
			make.bottom.trailing.equalToSuperview().offset(-4)
			make.leading.equalTo(valueLabel.snp.trailing).offset(4)
			make.size.equalTo(40)
		}

	}

	override func configureView() {
		keyLabel.textColor = .white
		keyLabel.backgroundColor = .clear
		keyLabel.font = .boldSystemFont(ofSize: 14)

		valueLabel.textColor = .white
		valueLabel.backgroundColor = .clear

		
		modifyButton.setImage(UIImage(systemName: "pencil"), for: .normal)
		modifyButton.tintColor = .white
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
