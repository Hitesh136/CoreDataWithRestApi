//
//  UsersViewController.swift
//  Players
//
//  Created by Hitesh  Agarwal on 16/10/19.
//  Copyright © 2019 Hitesh  Agarwal. All rights reserved.
//

import UIKit

class UsersViewController: BaseViewController {

	// MARK:- Outlets
	@IBOutlet weak var tableView: UITableView!
	
	// MARK:- Properties
	var viewModel = UserListViewModel()
	
	// MARK:- View Life Cycles
    override func viewDidLoad() {
		configureTableView()
		configureViewModel()
		super.viewDidLoad()
	}
}

// MARK:- Configurations
extension UsersViewController {
	func configureTableView() {
		tableView.tableFooterView = UIView()
		tableView.register(UINib(nibName: UserTableViewCell.className, bundle: nil), forCellReuseIdentifier: UserTableViewCell.className)
	}
	
	func configureViewModel() {
		tableView.delegate = self
		tableView.dataSource = self
		viewModel.fetchUsers { [weak self] (success) in
			
			DispatchQueue.main.async {
				self?.tableView.reloadData()				
			}
		}
	}
}

// MARK:- TableView DataSources
extension UsersViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel.rowsCount
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.className) as! UserTableViewCell
		
		cell.configureCell(forUser: viewModel.userViewModels[indexPath.row])
		return cell
	}
}

// MARK:- TableView Delegates
extension UsersViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let userDetailsViewController: UserDetailViewController = Storyboard.user.getViewController()
		userDetailsViewController.userViewModel = viewModel.userViewModels[indexPath.row]
		self.navigationController?.pushViewController(userDetailsViewController, animated: true)
	}
}

