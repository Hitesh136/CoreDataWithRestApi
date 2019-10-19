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
			
			userServiceManager.fetchAllUsers { [weak self] (result) in
				switch result {
					case .success(let users):
						let results = self?.userDBManager.save(users: users) ?? []
						completion(.success(results))
					case .failure(let error):
						completion(.failure(error))
				}
			}
		} else {
			let result = userDBManager.fetchAllUsers()
			switch result {
				case .success(let users):
					completion(.success(users.map{ $0.toUserModel()}))
				case .failure(let error):
					completion(.failure(error))
			}
		}
	}
	
	func updateFav(ofUserOfId userId: Int,
				   isFav: Bool,
				   completion: @escaping (Bool) -> ()) {
		
		/*Here we have scope to add support of update fav on server. Everything will be done in this class without affecting the other class.
		
		
		for Example:-
		if online {
			userServiceManager.updateFav(compleion: completion)
		} else {
			userDBManager.updateFav(ofUserOfId: userId, isFav: isFav, completion: completion)
		}
		*/
		userDBManager.updateFav(ofUserOfId: userId, isFav: isFav, completion: completion)
	}
	
	func get(userOfId userId: Int,
			 completion: @escaping (User?) -> ()) {
		
		/*
		if online {
			userServiceManager.fetch(userOfId: userId)
		} else {
			userDBManager.fetch(userOfId: userId)
		}
		*/
		let userEntity = userDBManager.fetch(userOfId: userId)
		let userModel = userEntity?.toUserModel()
		completion(userModel)
	}
}
