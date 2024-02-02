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
		}
	}

	var method: HTTPMethod {
		return .get
	}

	var parameter: Parameters {
		switch self {
		case .airingToday, .trend, .topRated, .popular, .recommend:
			["language": "ko-KR"]
			
		}
	}

	var encoding: URLEncoding {
		return .queryString
	}

	var header: HTTPHeaders {
		return ["Authorization": APIKey.tmdb]
	}




}
