//
//  CustomPresentationController.swift
//  SeSACMedia
//
//  Created by ungQ on 2/9/24.
//

import UIKit

final class HalfSizePresentationController: UIPresentationController {

	override var frameOfPresentedViewInContainerView: CGRect {
		let screenBounds = UIScreen.main.bounds

		let size = CGSize(width: screenBounds.width,
						  height: screenBounds.height * 0.5)

		let origin = CGPoint(x: .zero, y: screenBounds.height * 0.5)

		return CGRect(origin: origin, size: size)
	}

	override func presentationTransitionWillBegin() {
		
	}
}


class ModalViewController: UIViewController {
	override func viewDidLoad() {
		if let sheetPresentationController = sheetPresentationController {
			sheetPresentationController.detents = [.medium(), .large()]
		}
	}
}
