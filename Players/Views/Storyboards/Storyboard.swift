//
//  Storyboard.swift
//  Players
//
//  Created by Hitesh  Agarwal on 16/10/19.
//  Copyright © 2019 Hitesh  Agarwal. All rights reserved.
//

import Foundation
import UIKit

enum Storyboard: String {
	case user = "User"
	
	func getViewController<T: UIViewController>() -> T {
		let storyboard = UIStoryboard(name: self.rawValue, bundle: nil)
		if let viewController = storyboard.instantiateViewController(identifier: T.className) as? T {
			return viewController
		} else {
			fatalError("View Controller \(T.className) not found")
		}
	}
}
