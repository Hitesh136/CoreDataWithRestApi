//
//  UserDetailViewController.swift
//  Players
//
//  Created by Hitesh  Agarwal on 18/10/19.
//  Copyright © 2019 Hitesh  Agarwal. All rights reserved.
//

import UIKit

protocol UserDetailViewControllerDelegate: class {
	func update(userOfId userId: Int?)
}

class UserDetailViewController: BaseViewController {

	// MARK:- Outlets
	@IBOutlet weak var idLabel: UILabel!
	@IBOutlet weak var firstNameLabel: UILabel!
	@IBOutlet weak var lastNameLabel: UILabel!
	@IBOutlet weak var emailLabel: UILabel!
	@IBOutlet weak var favBarButton: UIBarButtonItem!
	
	// MARK:- Properties
	weak var delegate: UserDetailViewControllerDelegate?
	var userViewModel = UserViewModel()
	
	// MARK:- View Life Cycles
    override func viewDidLoad() {
		configureViewModel()
		configureView()
		configureNavigationBar()
		super.viewDidLoad()
	}
}

// MARK:- IBActions
extension UserDetailViewController {
	@IBAction func actionFav() {
		userViewModel.updateFav { [weak self] (success) in
			guard let self = self else {
				return
			}
			let message = success ? AlertMessage.favMarked : AlertMessage.favMarkedFail
			self.configureNavigationBar()
			CommonClass.alert(title: nil, message: message.rawValue)
			self.delegate?.update(userOfId: self.userViewModel.userId)
		}
	}
}
// MARK:- Configurations
extension UserDetailViewController {
	
	func configureView() {
		title = userViewModel.fullName
	}
	
	func configureViewModel() {
		if let userId = userViewModel.userId {
			self.idLabel.text = "\(userId)"
		}
		
		firstNameLabel.text = userViewModel.firstName
		lastNameLabel.text = userViewModel.lastName
		emailLabel.text = userViewModel.email
	}
	
	func configureNavigationBar() {
		if userViewModel.isFav {
			favBarButton.image = #imageLiteral(resourceName: "ic_Fav")
		} else {
			favBarButton.image = #imageLiteral(resourceName: "ic_notFav")
		}
	}
}
