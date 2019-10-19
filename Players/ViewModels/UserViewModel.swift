//
//  UserViewModel.swift
//  Players
//
//  Created by Hitesh  Agarwal on 17/10/19.
//  Copyright © 2019 Hitesh  Agarwal. All rights reserved.
//

import Foundation

class UserViewModel {
	
	var user = User()
	var userDataManager = UserDataManager()
	
	var firstName: String? {
		return user.firstName
	}
	
	var lastName: String? {
		return user.lastName
	}
	
	var userId: Int? {
		return user.id
	}
	
	var isFav: Bool {
		return user.isFav ?? false
	}
	
	var fullName: String? {
		var names = [String]()
		
		if let firstName = firstName {
			names.append(firstName)
		}
		
		if let lastName = lastName {
			names.append(lastName)
		}
		return names.joined(separator: " ")
	}
	
	var email: String? {
		return user.email
	}
	
	init(user: User) {
		self.user = user
	}
	
	init() {}
	
	func updateFav(completion: @escaping (Bool) -> ()) {
		guard let userId = userId else {
			return
		}
		userDataManager.updateFav(ofUserOfId: userId, isFav: !isFav) { [weak self] (success) in
			
			guard let self = self else {
				return
			}
			 
			self.user.isFav = success ? !self.isFav : self.isFav
			completion(success)
		}
	}
}
