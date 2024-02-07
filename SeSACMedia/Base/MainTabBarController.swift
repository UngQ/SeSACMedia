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

		self.tabBar.tintColor = .white
		self.tabBar.barTintColor = .black
		self.tabBar.isTranslucent = false
		self.tabBar.unselectedItemTintColor = .lightGray



		let firstVC = UINavigationController(rootViewController: TVViewController())
		firstVC.tabBarItem.title = "메인"
		firstVC.tabBarItem.image = UIImage(systemName: "house")

		let thirdVC = UINavigationController(rootViewController: ProfileViewController())
		thirdVC.tabBarItem.title = "프로필"
		thirdVC.tabBarItem.image = UIImage(systemName: "person")


		viewControllers = [firstVC, thirdVC]

    }


}
