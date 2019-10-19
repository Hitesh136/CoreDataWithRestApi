//
//  UserDataManager.swift
//  Players
//
//  Created by Hitesh  Agarwal on 16/10/19.
//  Copyright © 2019 Hitesh  Agarwal. All rights reserved.
//

import Foundation

class UserDataManager {

	let userServiceManager = UserServiceManger()
	let userDBManager = UserDBManager()
	
	func fetchUsers(completion: @escaping (Result<[User], Error>) -> ()) {
		
		if Reachability().isOnline {
			
			userServiceManager.fetchAllUsers { (result) in
				switch result {
					
					case .success(let users):
						let usersEntity = users.map{ $0.toEntity()}
						try? appDelegate.mainContext.save()
						completion(.success(users))
					case .failure(let error):
						completion(.failure(error))
				}
			}
		} else {
			userDBManager.fetchAllUsers(completion: completion)
		}
	}
	
	func updateFav(ofUserOfId userId: Int,
				   isFav: Bool,
				   completion: @escaping (Bool) -> ()) {
		
		//Here we have scope to add support of update fav on server. Everything will be done in this class without affecting the other class.
		userDBManager.updateFav(ofUserOfId: userId, isFav: isFav, completion: completion)

	}
}
