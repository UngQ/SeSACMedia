//
//  TMDBAPI.swift
//  SeSACMedia
//
//  Created by ungQ on 2/1/24.
//

import Foundation
import Alamofire

enum TMDBAPI {

	static let header: HTTPHeaders = ["Authorization": APIKey.tmdb]

	case main
	case trend
	case topRated
	case popular
	case recommend(id: Int)

	var baseURL: String {
		return "https://api.themoviedb.org/3/"
	}

	//		var title: String {
	//			switch self {
	//			case .main:
	//				return ""
	//			case .trend:
	//				return "이번 주 트렌드"
	//			case .topRated:
	//				return "이번 주 최고 평점"
	//			case .popular:
	//				return "이번 주 가장 인기 있는!"
	//		case .recommend:
	//			return "비슷한 컨텐츠"
	//			}
	//		}

	var endPoint: URL {
		switch self {
		case .main:
			return URL(string: baseURL + "tv/airing_today?language=ko-KR")!
		case .trend:
			return URL(string: baseURL + "trending/tv/week?language=ko-KR")!
		case .topRated:
			return URL(string: baseURL + "tv/top_rated?language=ko-KR")!
		case .popular:
			return URL(string: baseURL + "tv/popular?language=ko-KR")!
		case .recommend(let id):
			return URL(string: baseURL + "tv/\(id)/recommendations")!
		}
	}
}
