//
//  AppDelegate.swift
//  Players
//
//  Created by Hitesh  Agarwal on 16/10/19.
//  Copyright © 2019 Hitesh  Agarwal. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
	
	var window: UIWindow?
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		
		print(documentDirectoryPath)
		window = UIWindow(frame: UIScreen.main.bounds)
		showRootViewController()
		return true
	}
	
	// MARK: - Core Data stack
	lazy var persistentContainer: NSPersistentContainer = {
		let container = NSPersistentContainer(name: "Players")
		container.loadPersistentStores(completionHandler: { (storeDescription, error) in
			if let error = error as NSError? {
				fatalError("Unresolved error \(error), \(error.userInfo)")
			}
		})
		return container
	}()
	
	func saveContext () {
		let context = persistentContainer.viewContext
		if context.hasChanges {
			do {
				try context.save()
			} catch {
				let nserror = error as NSError
				fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
			}
		}
	}
	var mainContext: NSManagedObjectContext {
		return persistentContainer.viewContext
	}
	
	var documentDirectoryPath: String {
		let url = persistentContainer.persistentStoreCoordinator.persistentStores.first?.url
		return url?.absoluteString ?? ""
	}
}

// MARK:- Configurations Functions
extension AppDelegate {
	
	//Show the initial view controller
	func showRootViewController() {
		let userStoryboard = UIStoryboard(name: "User", bundle: nil)
		let usersViewController = userStoryboard.instantiateViewController(identifier: UsersViewController.className) as! UsersViewController
		let usersNavigationController = BaseNavigationController(rootViewController: usersViewController)
		window?.rootViewController = usersNavigationController
		window?.makeKeyAndVisible()
	}
}

//Dummy commnet 
