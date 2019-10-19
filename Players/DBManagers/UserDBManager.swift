//
//  UserDBManager.swift
//  Players
//
//  Created by Hitesh  Agarwal on 16/10/19.
//  Copyright © 2019 Hitesh  Agarwal. All rights reserved.
//

import Foundation
import CoreData

class UserDBManager {
	
	func fetchAllUsers(onContext context: NSManagedObjectContext? = nil) -> Result<[UserEntity], Error>{
		
		let context = context ?? appDelegate.mainContext
		let fetchRequest = NSFetchRequest<UserEntity>(entityName: EntityName.user.rawValue)
		do {
			let result = try context.fetch(fetchRequest)
			return .success(result)
		} catch let error {
			print(error.localizedDescription)
			return .failure(error)
		}
	}

	/*
	save the users into db.
	*/
	func save(users: [User],
			  replaceOldData: Bool = false,
			  onContext context: NSManagedObjectContext? = nil) -> [User]{

		let context = context ?? appDelegate.mainContext
		
		//Fetch all saved users
		let allUserEntities = fetchAllUsers(onContext: context)
		guard case .success(let userEntities) = allUserEntities  else {
			return []
		}
			
		//Create a hashmap for make search in O(1) Complexity
		var dict = [Int16: UserEntity]()
		userEntities.forEach{ dict[$0.userId] = $0 }
		var results = [User]()
		for newUser in users {
			guard let userId = newUser.id else {
				continue
			} 
			var userEntity: UserEntity
			if let savedUser = dict[Int16(userId)] {
				// if replaceOldData is true than use the new data
				userEntity = replaceOldData ? newUser.toEntity() : savedUser
			} else {
				userEntity = newUser.toEntity(onContext: context)
			}
			
			let userModel = userEntity.toUserModel()
			results.append(userModel)
		}
		try? context.save()
		return results
	}
	
	func fetch(userOfId userId: Int,
			   onContext context: NSManagedObjectContext? = nil) -> UserEntity? {
		
		let context = context ?? appDelegate.mainContext
		let fetchRequest = NSFetchRequest<UserEntity>(entityName: EntityName.user.rawValue)
		fetchRequest.predicate = NSPredicate(format: "userId == %d", userId)
		do {
			let result = try context.fetch(fetchRequest)
			return result.first
		} catch let error {
			print(error.localizedDescription)
			return nil
		}
	}
	
	func updateFav(ofUserOfId userId: Int,
				   isFav: Bool,
				   onContext context: NSManagedObjectContext? = nil,
				   completion: (Bool) -> ()) {
		
		let context = context ?? appDelegate.mainContext
		let userEntity = fetch(userOfId: userId, onContext: context)
		
		guard let user = userEntity else {
			completion(false)
			return
		}
		user.isFav = isFav
		do {
			try context.save()
			completion(true)
		}
		catch let error {
			print(error.localizedDescription)
			completion(false)
		}
	}
}
