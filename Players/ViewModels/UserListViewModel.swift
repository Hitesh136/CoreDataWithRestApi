//
//  UserListViewModel.swift
//  Players
//
//  Created by Hitesh  Agarwal on 18/10/19.
//  Copyright © 2019 Hitesh  Agarwal. All rights reserved.
//

import Foundation

class UserListViewModel {
	
	var userViewModels = [UserViewModel]()
	var userDataManager = UserDataManager()
	
	var rowsCount: Int {
		return userViewModels.count
	}
	
	func fetchUsers(completion: @escaping (Bool) -> ()) {
		userDataManager.fetchUsers { [weak self] (result) in
			guard let self = self else {
				return
			}
			switch result {
				case .success(let users):
					self.userViewModels = users.map{ UserViewModel(user: $0) }
					completion(true)
				case .failure(_):
					completion(false)
			}
		}
	}
	
	func update(userOfId userId: Int, completion: (Bool) -> ()) {
		guard let userIndex = userViewModels.firstIndex(where: { $0.userId == userId }) else {
			completion(false)
			return
		}
		userDataManager.get(userOfId: userId) { [weak self] (user) in
			if let _user = user {
                self?.userViewModels[userIndex].user = _user
				completion(true)
			} else {
				completion(false)
			}
		}
	}
}
