//
//  Storyboarded.swift
//  ios-online-cinema
//
//  Created by Sergei Kulagin on 01.08.2023.
//

import UIKit

protocol Storyboarded {
    static func instatiate() -> Self
}

extension Storyboarded where Self: UIViewController {
    static func instantiate() -> Self {
        let fullName = NSStringFromClass(self)
        let className = fullName.components(separatedBy: ".")[1]
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: className) as! Self
    }
}
