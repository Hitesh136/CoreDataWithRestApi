//
//  UserServiceManager.swift
//  Players
//
//  Created by Hitesh  Agarwal on 16/10/19.
//  Copyright © 2019 Hitesh  Agarwal. All rights reserved.
//

import Foundation

/*
This class contains all user releated api requests.
*/
class UserServiceManger {
	
	func fetchAllUsers(completion: @escaping (Result<[User], Error>) -> ()) {
		
		let userServiceRequest = ServiceHandler<UserResponse>()
		userServiceRequest.request(url: AppURL.users.rawValue, method: .get) { (result) in
			
			switch result {
				case .success(let decodedObject):
					completion(.success(decodedObject.data))
				case .failure(let error):
					completion(.failure(error))
			}
		}
	}
}
