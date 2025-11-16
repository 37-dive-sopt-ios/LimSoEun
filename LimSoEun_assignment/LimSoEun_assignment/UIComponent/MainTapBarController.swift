//
//  MainTapBarController.swift
//  LimSoEun_assignment
//
//  Created by 임소은 on 11/7/25.
//

import UIKit

final class MainTapBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        setupViewControlers()
    }
    
    private func setupTabBar() {
        tabBar.backgroundColor = .baeminWhite
        tabBar.tintColor = .baeminBlack
        tabBar.unselectedItemTintColor = .baeminGray300
        tabBar.isTranslucent = false
    }
    
    private func setupViewControllers() {
        let homeVC = HomeViewController()
        let shoppingVC = UIViewController()
        let favoriteVC = UIViewController()
        let orderVC = UIViewController()
        let myVC = UIViewController()
        
        shoppingVC.view.backgroundColor = .baeminGray300
        favoriteVC.view.backgroundColor = .baeminGray700
        orderVC.view.backgroundColor = .baeminMint300
        myVC.view.backgroundColor = .baeminMint500
        
        homeVC.tabBarItem = UITabBarItem (
            title: "홈",
            image: UIImage(named: "home_filled"), //TODO: - 선택 컴포넌트 수정
            selectedImage: UIImage(named: "home_filled")
        )
        shoppingVC.tabBarItem = UITabBarItem (
            title: "장보기·쇼핑",
            image: UIImage(named: "shopping"), //TODO: - 선택 컴포넌트 수정
            selectedImage: UIImage(named: "shopping")
        )
        favoriteVC.tabBarItem = UITabBarItem (
            title: "찜",
            image: UIImage(named: "heart"), //TODO: - 선택 컴포넌트 수정
            selectedImage: UIImage(named: "heart")
        )
        orderVC.tabBarItem = UITabBarItem (
            title: "홈",
            image: UIImage(named: "order"), //TODO: - 선택 컴포넌트 수정
            selectedImage: UIImage(named: "order")
        )
        myVC.tabBarItem = UITabBarItem (
            title: "마이배민",
            image: UIImage(named: "face"), //TODO: - 선택 컴포넌트 수정
            selectedImage: UIImage(named: "face")
        )
        
        viewControllers = [homeVC, shoppingVC, favoriteVC, orderVC, myVC]
    }
}
