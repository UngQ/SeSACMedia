//
//  BaseViewController.swift
//  SeSACMedia
//
//  Created by ungQ on 1/31/24.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

		view.backgroundColor = .black

		configureHierarchy()
		configureLayout()
		configureView()
  }


	func configureHierarchy() {}

	func configureLayout() {}

	func configureView() {}


}
