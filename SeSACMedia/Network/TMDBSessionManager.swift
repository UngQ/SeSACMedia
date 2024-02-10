//
//  TMDBSessionManager.swift
//  SeSACMedia
//
//  Created by ungQ on 2/5/24.
//

import Foundation


final class TMDBSessionManager {

	static let shared = TMDBSessionManager()
	private init() {}


	func fetchSearchingMovie(query: String, completionHandler: @escaping (TVModel?, Error?) -> Void) {
		var url = URLRequest(url: TMDBAPI.search(query: query).endPoint)
		url.httpMethod = "GET"

		url.addValue(APIKey.tmdb, forHTTPHeaderField: "Authorization")

		


			URLSession.shared.dataTask(with: url) { data, response, error in
				DispatchQueue.main.async {
					
				guard error == nil else { completionHandler(nil, error)
					return }

				guard let data = data else { completionHandler(nil, error)
					return }

				guard let response = response as? HTTPURLResponse else { completionHandler(nil, error)
					return }

				do {
					let result = try JSONDecoder().decode(TVModel.self, from: data)
					dump(result)
					completionHandler(result, nil)
				} catch {
					completionHandler(nil, error)
				}

			}
		}.resume()
	}
}
