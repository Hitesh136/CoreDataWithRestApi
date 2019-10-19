//
//  UserTableViewCell.swift
//  Players
//
//  Created by Hitesh  Agarwal on 17/10/19.
//  Copyright © 2019 Hitesh  Agarwal. All rights reserved.
//

import UIKit

class UserTableViewCell: BaseTableViewCell {

	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var favIcon: UIImageView!
	
    override func awakeFromNib() {
        super.awakeFromNib()
		self.selectionStyle = .none
		
    }
	
	func configureCell(forUser user: UserViewModel) {
		nameLabel.text = user.fullName
		favIcon.isHighlighted = user.isFav
	}
}
