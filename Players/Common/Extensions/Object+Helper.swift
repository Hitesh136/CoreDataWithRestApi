//
//  Object.swift
//  Players
//
//  Created by Hitesh  Agarwal on 16/10/19.
//  Copyright © 2019 Hitesh  Agarwal. All rights reserved.
//

import Foundation

extension NSObject {
	
	static var className: String {
		return String(describing: self)
	}
}
