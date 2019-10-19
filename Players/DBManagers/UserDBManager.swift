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
	
	func fetchAllUsers(onContext context: NSManagedObjectContext? = nil,
					   completion: @escaping (Result<[User], Error>) -> ()) {
		
		let context = context ?? appDelegate.mainContext
		let fetchRequest = NSFetchRequest<UserEntity>(entityName: EntityName.user.rawValue)
		do {
			let result = try context.fetch(fetchRequest)
			completion(.success(result.map{ $0.toUserModel() }))
		} catch let error {
			print(error.localizedDescription)
			completion(.failure(error))
		}
	}
	
	func fetch(userOfId userId: Int,
			   onContext context: NSManagedObjectContext? = nil) -> UserEntity? {
		
		let context = context ?? appDelegate.mainContext
		let fetchRequest = NSFetchRequest<UserEntity>(entityName: EntityName.user.rawValue)
		
		let _userId = Int16(userId)
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
