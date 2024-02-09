//
//  NaverModel.swift
//  SeSACMedia
//
//  Created by ungQ on 2/8/24.
//

import Foundation

struct NaverImageModel: Codable {
	let lastBuildDate: String
	let total, start, display: Int
	let items: [Item]
}

struct Item: Codable {
	let title: String
	let link: String
	let thumbnail: String
	let sizeheight, sizewidth: String
}
