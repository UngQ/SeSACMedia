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

	func fetchTVList(url: String, completionHandler: @escaping ([TV]) -> Void) {
		let url = url

		let header: HTTPHeaders = ["Authorization": APIKey.tmdb]

		AF.request(url, headers: header).responseDecodable(of: TrendingModel.self) { response in
			switch response.result {
			case .success(let success):
				completionHandler(success.results)
			case .failure(let failure):
				dump(failure)
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
				dump(success)
				completionHandler(success.cast)
			case .failure(let failure):
				dump(failure)
			}
		}
	}

	func fetchRecommendList(id: Int, completionHandler: @escaping ([RecommendModelResult]) -> Void) {
		let url = "https://api.themoviedb.org/3/tv/\(id)/recommendations"

		let header: HTTPHeaders = ["Authorization": APIKey.tmdb]

		AF.request(url, headers: header).responseDecodable(of: RecommendModel.self) { response in
			switch response.result {
			case .success(let success):

				completionHandler(success.results)
			case .failure(let failure):
				dump(failure)
			}
		}
	}

}



