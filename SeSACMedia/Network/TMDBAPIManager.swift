//
//  TMDBAPIManager.swift
//  SeSACMedia
//
//  Created by ungQ on 1/30/24.
//

import Foundation
import Alamofire

class TMDBAPIManager {

	static let shared = TMDBAPIManager()
	private init() {}

	func request<T: Decodable>(type: T.Type, api: TMDBAPI, completionHandler: @escaping (T) -> Void) {

		AF.request(api.endPoint,
				   method: api.method,
				   parameters: api.parameter,
				   encoding: api.encoding,
				   headers: api.header).responseDecodable(of: T.self) { response in
			switch response.result {
			case .success(let success):
				completionHandler(success)
			case .failure(let failure):
				print(failure)

			}
		}
	}

	func fetchTVList(api: TMDBAPI, completionHandler: @escaping ([TV]) -> Void) {

		AF.request(api.endPoint,
				   headers: api.header).responseDecodable(of: TVModel.self) { response in
			switch response.result {
			case .success(let success):
				completionHandler(success.results ?? [])
			case .failure(let failure):
				debugPrint(failure)
			}
		}
	}

	func fetchTVDetailInfo(id: Int, completionHandler: @escaping (DetailTVModel) -> Void) {
		let url = "https://api.themoviedb.org/3/tv/\(id)?language=ko-KR"

		let header: HTTPHeaders = ["Authorization": APIKey.tmdb]

		AF.request(url, headers: header).responseDecodable(of: DetailTVModel.self) { response in
			switch response.result {
			case .success(let success):
				completionHandler(success)
			case .failure(let failure):
				dump(failure)
			}
		}
	}

	func fetchCastInfo(id: Int, completionHandler: @escaping ([Cast]) -> Void) {
		let url = "https://api.themoviedb.org/3/tv/\(id)/aggregate_credits"

		let header: HTTPHeaders = ["Authorization": APIKey.tmdb]

		AF.request(url, headers: header).responseDecodable(of: CastModel.self) { response in
			switch response.result {
			case .success(let success):
				completionHandler(success.cast)
			case .failure(let failure):
				dump(failure)
			}
		}
	}
}
