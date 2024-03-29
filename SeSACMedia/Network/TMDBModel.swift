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
	let seasonNumber: Int

	enum CodingKeys: String, CodingKey {
		case id
		case name
		case overview
		case poster = "poster_path"
		case airDate = "air_date"
		case voteAverage = "vote_average"
		case seasonNumber = "season_number"
	}


}


//


struct CastModel: Decodable {
	let cast: [Cast]
}

struct Cast: Decodable {
	let name: String
	let profilePath: String?

	enum CodingKeys: String, CodingKey {
		case name
		case profilePath = "profile_path"
	}
}


//



struct VideoModel: Decodable {
	let id: Int
	let results: [Result]?
}

struct Result: Decodable, Equatable {
	let iso639_1, iso3166_1, name, key: String
	let publishedAt, site: String
	let size: Int
	let type: String
	let official: Bool
	let id: String

	enum CodingKeys: String, CodingKey {
		case iso639_1 = "iso_639_1"
		case iso3166_1 = "iso_3166_1"
		case name, key
		case publishedAt = "published_at"
		case site, size, type, official, id
	}
}


//

struct EpisodeModel: Codable {
	let episodes: [Episode]?
	let poster_path: String?
}


struct Episode: Codable {

	let episodeNumber: Int
	let id: Int
	let name, overview: String
	let seasonNumber: Int
	let stillPath: String?

	enum CodingKeys: String, CodingKey {
		case episodeNumber = "episode_number"
		case id, name, overview
		case seasonNumber = "season_number"
		case stillPath = "still_path"

	}
}
