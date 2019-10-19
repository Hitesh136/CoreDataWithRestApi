//
//  Constants.swift
//  Players
//
//  Created by Hitesh  Agarwal on 16/10/19.
//  Copyright © 2019 Hitesh  Agarwal. All rights reserved.
//

import Foundation
import UIKit

let appDelegate = UIApplication.shared.delegate as! AppDelegate

enum EntityName: String {
	case user = "UserEntity"
}

enum AlertMessage: String {
	case favMarked = "User has been marked fav"
	case favMarkedFail = "User can't marked fav"
}
