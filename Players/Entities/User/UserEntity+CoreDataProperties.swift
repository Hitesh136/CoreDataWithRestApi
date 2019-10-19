//
//  UserEntity+CoreDataProperties.swift
//  Players
//
//  Created by Hitesh  Agarwal on 16/10/19.
//  Copyright © 2019 Hitesh  Agarwal. All rights reserved.
//
//

import Foundation
import CoreData


extension UserEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserEntity> {
        return NSFetchRequest<UserEntity>(entityName: "UserEntity")
    }

    @NSManaged public var userId: Int16
    @NSManaged public var email: String?
    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
	@NSManaged public var isFav: Bool
}

