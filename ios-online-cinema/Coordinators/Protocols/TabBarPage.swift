//
//  TabBarPage.swift
//  ios-online-cinema
//
//  Created by Sergei Kulagin on 04.08.2023.
//

import Foundation
import UIKit

enum TabBarPage {
    case moviesFeed
    case favouriteMovies
    
    init?(index: Int) {
        switch index {
        case 0:
            self = .moviesFeed
        case 1:
            self = .favouriteMovies
        default:
            return nil
        }
    }
    
    func pageTitleValue() -> String {
        switch self {
        case .moviesFeed:
            return "Feed"
        case .favouriteMovies:
            return "Favourite"
        }
    }
    
    func pageOrderNumber() -> Int {
        switch self {
        case .moviesFeed:
            return 0
        case .favouriteMovies:
            return 1
        }
    }
    
    func pageIcon() -> UIImage? {
        switch self {
        case .moviesFeed:
            return UIImage(named: "feed")
        case .favouriteMovies:
            return UIImage(named: "like")
        }
    }
}
