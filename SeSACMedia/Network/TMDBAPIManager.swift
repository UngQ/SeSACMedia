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
	static let dispatchGroup = DispatchGroup()

	private init() {}

	func request<T: Decodable>(type: T.Type, api: TMDBAPI, completionHandler: @escaping (T) -> Void) {
		TMDBAPIManager.dispatchGroup.enter()

		AF.request(api.endPoint,
				   method: api.method,
				   parameters: api.parameter,
				   encoding: api.encoding,
				   headers: api.header).responseDecodable(of: T.self) { response in
			switch response.result {
			case .success(let success):
				completionHandler(success)
			case .failure(let failure):
				dump(failure)
			}
			TMDBAPIManager.dispatchGroup.leave()
		}
	}
}
