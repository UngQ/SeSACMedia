//
//  TrendingModel.swift
//  SeSACMedia
//
//  Created by ungQ on 1/30/24.
//

import Foundation


struct TVModel: Decodable {
	let results: [TV]?
}

struct TV: Decodable {
	let id: Int
	let name: String
	let posterPath: String?


	enum CodingKeys: String, CodingKey {
		case id
		case name
		case posterPath = "poster_path"

	}
}

//

struct DetailTVModel: Decodable {
	let id: Int
	let name: String
	let overview: String?
	let seasons: [SeasonInfo]?
	let poster: String?
	let firstAirDate: String?
	let lastAirDate: String?
	let voteAverage: Double?

	enum CodingKeys: String, CodingKey {
		case id
		case name
		case overview
		case seasons
		case poster = "poster_path"
		case firstAirDate = "first_air_date"
		case lastAirDate = "last_air_date"
		case voteAverage = "vote_average"
	}
}

struct SeasonInfo: Decodable {
	let id: Int?
	let name: String?
	let overview: String?
	let poster: String?
	let airDate: String?
	let voteAverage: Double?

	enum CodingKeys: String, CodingKey {
		case id
		case name
		case overview
		case poster = "poster_path"
		case airDate = "air_date"
		case voteAverage = "vote_average"
	}


}


//


struct CastModel: Codable {
	let cast: [Cast]
}

struct Cast: Codable {
	let profilePath: String?

	enum CodingKeys: String, CodingKey {
		case profilePath = "profile_path"
	}
}
