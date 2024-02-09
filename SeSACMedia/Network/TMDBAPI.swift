//
//  TMDBAPI.swift
//  SeSACMedia
//
//  Created by ungQ on 2/1/24.
//

import Foundation
import Alamofire

enum TMDBAPI {

	case airingToday
	case trend
	case topRated
	case popular
	case recommend(id: Int)
	case detailInfo(id: Int)
	case cast(id: Int)
	case search(query: String)
	case video(id: Int)

	var baseURL: String {
		return "https://api.themoviedb.org/3/"
	}

	var endPoint: URL {
		switch self {
		case .airingToday:
			return URL(string: baseURL + "tv/airing_today")!
		case .trend:
			return URL(string: baseURL + "trending/tv/week")!
		case .topRated:
			return URL(string: baseURL + "tv/top_rated")!
		case .popular:
			return URL(string: baseURL + "tv/popular")!
		case .recommend(let id):
			return URL(string: baseURL + "tv/\(id)/recommendations")!
		case .detailInfo(let id):
			return URL(string: baseURL + "tv/\(id)")!
		case .cast(let id):
			return URL(string: baseURL + "tv/\(id)/aggregate_credits")!
		case .search(query: let query):
			return URL(string: baseURL + "search/tv?language=ko-KR&query=\(query)")!
		case .video(let id):
			return URL(string: baseURL + "tv/\(id)/videos")!
		}
	}

	var method: HTTPMethod {
		return .get
	}

	var parameter: Parameters {
		switch self {
		case .airingToday, .trend, .topRated, .popular, .recommend, .detailInfo, .cast, .video:
			["language": "ko-KR"]

		case .search(query: let query):
			["language": "ko-KR", "query": "\(query)"]


		}
	}

	var encoding: URLEncoding {
		return .queryString
	}

	var header: HTTPHeaders {
		return ["Authorization": APIKey.tmdb]
	}

}
