//
//  TabBarViewController.swift
//  ios-online-cinema
//
//  Created by Sergei Kulagin on 02.08.2023.
//

import UIKit

class TabBarViewController: UITabBarController, Coordinating {
    var coordinator: Coordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
    }
}
