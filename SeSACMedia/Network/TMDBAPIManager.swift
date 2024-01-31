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
			}
		}
	}

}

