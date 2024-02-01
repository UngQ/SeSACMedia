//
//  MainTabBarController.swift
//  SeSACMedia
//
//  Created by ungQ on 1/31/24.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

		self.tabBar.tintColor = .lightGray
		self.tabBar.barTintColor = .black
		self.tabBar.isTranslucent = false
		self.tabBar.unselectedItemTintColor = .white



		let firstVC = UINavigationController(rootViewController: TVViewController())
		firstVC.tabBarItem.title = "메인"
		firstVC.tabBarItem.image = UIImage(systemName: "house")


		viewControllers = [firstVC]

    }


}
