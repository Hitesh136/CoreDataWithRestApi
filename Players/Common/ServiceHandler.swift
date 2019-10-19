//
//  ServiceHandler.swift
//  Players
//
//  Created by Hitesh  Agarwal on 16/10/19.
//  Copyright © 2019 Hitesh  Agarwal. All rights reserved.
//

import Foundation
enum HTTPMethod: String {
	case get = "GET"
	case post = "POST"
}

enum NetworkError: String, Error {
	case invalidURL = "URL is not Valid"
	case unknown = "unkowne"
	case sessionExpire = "The Session has Expired"
	case internalServerError = "Looks like server is not working"
	case decodingError = "Something is wrong with codable object"
}

class ServiceHandler<T: Codable> {
	
	func request(url: String,
				 method: HTTPMethod,
				 completionHandler completion: @escaping (Result<T, NetworkError>) -> ()) {
		
		let finalPath = AppURL.baseURL.rawValue +  url
		guard let finalURL = URL(string: finalPath) else {
			completion(.failure(.invalidURL))
			return
		}
		
		CommonClass.showLoader()
		
		URLSession.shared.dataTask(with: finalURL) { (data, response, error) in
		
			DispatchQueue.main.async {
				CommonClass.hideLoader()
				guard let httpResponse = response as? HTTPURLResponse,
					let responseData = data else {
						completion(.failure(.unknown))
						return
				}
				
				let statusCode = httpResponse.statusCode
				if (200...204).contains(statusCode) {
					let jsonDecoder = JSONDecoder()
					do {
						let decodedObject = try jsonDecoder.decode(T.self, from: responseData)
						completion(.success(decodedObject))
					} catch let error {
						print(error.localizedDescription)
						completion(.failure(.decodingError))
					}
				} else if statusCode == 500 {
					print("Something went wrong with server")
					completion(.failure(.internalServerError))
				} else if statusCode == 401 {
					print("Session expire")
					completion(.failure(.sessionExpire))
				} else {
					print(error?.localizedDescription ?? "")
					completion(.failure(.unknown))
				}
			}
		}.resume()
	}
}

 
