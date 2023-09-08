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
    case moviesGenerator
    
    init?(index: Int) {
        switch index {
        case 0:
            self = .moviesFeed
        case 2:
            self = .moviesGenerator
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
        case .moviesGenerator:
            return "Generator"
        case .favouriteMovies:
            return "Favourite"
        }
    }
    
    func pageOrderNumber() -> Int {
        switch self {
        case .moviesFeed:
            return 0
        case .moviesGenerator:
            return 1
        case .favouriteMovies:
            return 2
        }
    }
    
    func pageIcon() -> UIImage? {
        switch self {
        case .moviesFeed:
            return UIImage(systemName: "list.bullet")
        case .moviesGenerator:
            return UIImage(systemName: "paperplane")
        case .favouriteMovies:
            return UIImage(systemName: "heart")
        }
    }
}
