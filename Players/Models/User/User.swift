//
//  User.swift
//  Players
//
//  Created by Hitesh  Agarwal on 16/10/19.
//  Copyright © 2019 Hitesh  Agarwal. All rights reserved.
//

import Foundation
import CoreData

// MARK: - User
struct UserResponse: Codable {
	let data: [User]
}

// MARK: - Datum
struct User: Codable {
	let id: Int?
	let email, firstName, lastName: String?
	var isFav: Bool?
	
	enum CodingKeys: String, CodingKey {
		case id, email, isFav
		case firstName = "first_name"
		case lastName = "last_name"
	}
}

extension User {
	
	init() {
		id = nil
		email = nil
		firstName = nil
		lastName = nil
		isFav = nil
	}
	
	func toEntity(onContext context: NSManagedObjectContext? = nil) -> UserEntity {
		let context = context ?? appDelegate.mainContext
		let userEntity = UserEntity(context: context)
		if let userId = id {
			userEntity.userId = Int16(userId)			
		}
		userEntity.email = email
		userEntity.firstName = firstName
		userEntity.lastName = lastName
		userEntity.isFav = isFav ?? false
		return userEntity
	}
}

