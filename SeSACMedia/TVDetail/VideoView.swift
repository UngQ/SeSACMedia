//
//  VideoView.swift
//  SeSACMedia
//
//  Created by ungQ on 2/9/24.
//

import UIKit
import WebKit
import SnapKit

final class VideoView: BaseView {

	let webView = WKWebView()

	override func configureHierarchy() {
		addSubview(webView)
	}


	override func configureLayout() {
		webView.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}
	}



}
