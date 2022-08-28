//
//  TabBarController.swift
//  DemoAisle
//
//  Created by Rakshith on 27/08/22.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {
    
    struct Dependencies {
        let phoneNumber: PhoneNumber
        let server: ServerType
    }
    
    let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        UITabBar.appearance().barTintColor = .white
        tabBar.tintColor = .label
        tabBar.backgroundColor = .white
        setupVCs()
        selectedIndex = 1
    }
    
    func setupVCs() {
          viewControllers = [
            createNavController(for: UIViewController(), title: Copy.discover.value, image: "dashboard", selectedImage: "dashboard_Selected"),
            createNavController(for: NoteViewController(), title: Copy.notes.value, image: "note", selectedImage: "note_Selected", badgeValue: "9"),
            createNavController(for: UIViewController(), title: Copy.matches.value, image: "matches", selectedImage: "matches_Selected", badgeValue: "50+"),
            createNavController(for: UIViewController(), title: Copy.profile.value, image:"profile", selectedImage: "profile_Selected")

          ]
      }
    
    fileprivate func createNavController(for rootViewController: UIViewController,
                                                    title: String,
                                                    image: String,
                                         selectedImage: String, badgeValue: String? = nil) -> UIViewController {
          let navController = UINavigationController(rootViewController: rootViewController)
          navController.tabBarItem.title = title
          navController.tabBarItem.image = UIImage(named: image)
          navController.tabBarItem.selectedImage = UIImage(named: selectedImage)
          
         if let value = badgeValue {
            navController.tabBarItem.badgeValue = value
            navController.tabBarItem.badgeColor = .purple
         }
          return navController
      }
}
