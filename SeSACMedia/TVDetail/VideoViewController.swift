//
//  VideoViewController.swift
//  SeSACMedia
//
//  Created by ungQ on 2/9/24.
//

import UIKit
import WebKit


class VideoViewController: BaseViewController {

	let key = UserDefaults.standard.string(forKey: "Key")!

	let mainView = VideoView()

	override func loadView() {
		view = mainView
	}

    override func viewDidLoad() {
        super.viewDidLoad()

		openYoutubePage()

		if let sheetPresentationController = sheetPresentationController {
			sheetPresentationController.detents = [.large(), .medium()]
			sheetPresentationController.prefersGrabberVisible = true

		}

    }

	func openYoutubePage() {
		let url = URL(string: "http://www.youtube.com/watch?v=\(key)")
		let request = URLRequest(url: url!)
		mainView.webView.load(request)
	}


}
