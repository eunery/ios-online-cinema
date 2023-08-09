//
//  APIMethods.swift
//  ios-online-cinema
//
//  Created by Sergei Kulagin on 09.08.2023.
//

import Foundation

enum APIMethods {
    case get
    case post
    
    func type() -> String {
        switch self {
        case .get:
            return "GET"
        case .post:
            return "POST"
        }
    }
}
