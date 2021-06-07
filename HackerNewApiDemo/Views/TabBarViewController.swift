//
//  TabBarViewController.swift
//  HackerNewApiDemo
//
//  Created by jyothish.johnson on 27/03/21.
//

import UIKit
import SwiftUI

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITabBar.appearance().tintColor = .purple
        
        let topVC = ViewController()
        topVC.vcType = .normal
        topVC.title = "Marvel Icons"
        topVC.navigationItem.largeTitleDisplayMode = .never
        let latestVC = UIHostingController(rootView: PayHome())
        latestVC.title = "Comics"
        latestVC.navigationItem.largeTitleDisplayMode = .never
        let bookmarkVC = ViewController()
        topVC.vcType = .favourites
        bookmarkVC.title = "Favs"
        bookmarkVC.navigationItem.largeTitleDisplayMode = .never

        
        let navOne = UINavigationController(rootViewController: topVC)
        navOne.navigationBar.prefersLargeTitles = false
        navOne.tabBarItem = UITabBarItem(title: "Icons", image: UIImage(systemName: "bolt"), tag: 0)
        
        let navTwo = UINavigationController(rootViewController: latestVC)
        navTwo.navigationBar.prefersLargeTitles = false
        navTwo.tabBarItem = UITabBarItem(title: "Comics", image: UIImage(systemName: "books.vertical"), tag: 1)
        
        let navThree = UINavigationController(rootViewController: bookmarkVC)
        navThree.navigationBar.prefersLargeTitles = false
        navThree.tabBarItem = UITabBarItem(title: "Bookmarks", image: UIImage(systemName: "bookmark"), tag: 2)
        
        self.setViewControllers([navOne,navTwo,navThree], animated: true)
        
    }
}

enum MarvelCharacterVCType {
    case normal
    case favourites
}
