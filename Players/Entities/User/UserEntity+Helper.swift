//
//  UserEntity+Helper.swift
//  Players
//
//  Created by Hitesh  Agarwal on 19/10/19.
//  Copyright © 2019 Hitesh  Agarwal. All rights reserved.
//

import Foundation

extension UserEntity {
	func toUserModel() -> User {
		
		return User(id: Int(userId),
					email: email,
					firstName: firstName,
					lastName: lastName,
					isFav: isFav)
	}
}
