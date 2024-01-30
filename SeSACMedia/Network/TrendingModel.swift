//
//  TrendingModel.swift
//  SeSACMedia
//
//  Created by ungQ on 1/30/24.
//

import Foundation


struct TrendingModel: Decodable {
	let results: [TV]
}

struct TV: Decodable {
	let name: String
	let poster: String
	let adult: Bool

	enum CodingKeys: String, CodingKey {
		case name
		case poster = "poster_path"
		case adult
	}
}
