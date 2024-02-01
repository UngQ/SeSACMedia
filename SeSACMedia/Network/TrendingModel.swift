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
	let poster: String?
	let id: Int

	enum CodingKeys: String, CodingKey {
		case name
		case poster = "poster_path"
		case id
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



//struct CastListModel: Decodable {
//	let castList: [Cast]?
//}
//
//struct Cast: Decodable {
//	let name: String?
//	let profile: String?
//
//	enum CodingKeys: String, CodingKey {
//		case name
//		case profile = "profile_path"
//	}
//}


struct CastModel: Codable {
	let cast: [Cast]
}

struct Cast: Codable {
	let profilePath: String?

	enum CodingKeys: String, CodingKey {
		case profilePath = "profile_path"
	}
}



//



struct RecommendModel: Codable {
	let results: [RecommendModelResult]
}

struct RecommendModelResult: Codable {
	let id: Int
	let posterPath: String?

	enum CodingKeys: String, CodingKey {
		case id
		case posterPath = "poster_path"
	}
}
